from django.contrib.auth import get_user_model
from datetime import datetime
from django.utils import timezone
import pytz
from rest_framework import serializers
from .models import *
from .common.enums import *
import logging

logger = logging.getLogger(__name__)


class FullUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'user_id', 'first_name', 'last_name', 'email', 'gender', 'country',
            'phone_number', 'bio', 'profile_picture'
        ]


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['user_id', 'first_name', 'last_name',
                  'email', 'gender', 'country', 'phone_number', 'bio']


class CourseAdminSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = ['course_id', 'name', 'description',
                  'requirements', 'access_link']

    def to_representation(self, instance):
        repr_ = super().to_representation(instance)
        repr_['order'] = instance.order
        return repr_
    
    def validate(self, attrs):
        return super().validate(attrs)


class CreateCohortTrack(serializers.ModelSerializer):

    class Meta:
        model = Track
        fields = ['track_id', 'name', 'description',
                  'courses', 'parent', 'cohort']

    def create(self, validated_data):
        courses_data = validated_data.pop('courses')
        track = Track.objects.create(**validated_data)
        for course_data in courses_data:
            Course.objects.create(**course_data, track=track)
        return track
    
class CourseSerializer(serializers.Serializer):
    course_id = serializers.UUIDField(read_only=True)
    name = serializers.CharField(max_length=200)
    description = serializers.CharField(max_length=500)
    requirements = serializers.CharField(max_length=500)
    access_link = serializers.CharField(max_length=500)
    track_id = serializers.UUIDField()

    def create(self, validated_data):
        track_id = validated_data.pop('track_id')
        track = Track.objects.get(track_id=track_id)
        course = Course.objects.create(track=track, **validated_data)
        return course

class CourseSerializer2(serializers.Serializer):
    course_id = serializers.UUIDField(read_only=True)
    name = serializers.CharField(max_length=200)
    description = serializers.CharField(max_length=500)
    requirements = serializers.CharField(max_length=500)
    access_link = serializers.CharField(max_length=500)
    
class AddCourseToTrackSerializer(serializers.Serializer):
    # add track_id and list of courses
    track_id = serializers.UUIDField()
    courses = CourseSerializer2(many=True)

    def create(self, validated_data):
        track_id = validated_data.pop('track_id')
        track = Track.objects.get(track_id=track_id)
        courses = validated_data.pop('courses')
        for course in courses:
            Course.objects.create(track=track, **course)
        return track
    
    # add validation to ensure each course is unique from all other courses in the track
    def validate(self, data):
        courses = data.get('courses')
        for course in courses:
            if Course.objects.filter(name=course.get('name'), track=data.get('track_id')).exists():
                raise serializers.ValidationError({"message":"A course with this name already exists in this track \U0001F636"})
        return super(AddCourseToTrackSerializer, self).validate(data)
    
class CourseUpdateSerializer(serializers.Serializer):
    course_id = serializers.UUIDField()
    name = serializers.CharField(max_length=200)
    description = serializers.CharField(max_length=500)
    requirements = serializers.CharField(max_length=500)
    access_link = serializers.CharField(max_length=500)
    
class TrackSerializer(serializers.ModelSerializer):
    courses = CourseAdminSerializer(many=True,)

    class Meta:
        model = Track
        fields = ['track_id', 'name', 'description', 'courses']

    def create(self, validated_data):
        courses_data = validated_data.pop('courses')
        track = Track.objects.create(**validated_data)
        for course_data in courses_data:
            Course.objects.create(**course_data, track=track)
        return track

    def update(self, instance, validated_data):
        instance.name = validated_data.get('name', instance.name)
        instance.description = validated_data.get(
            'description', instance.description)
        instance.save()

        courses = validated_data.pop('courses')

        for course_data in courses:
            course_id = course_data.get('course_id')
            edit_course = Course.objects.filter(
                course_id=course_id, track=instance).first()
            if edit_course:
                edit_course.name = course_data.get('name', edit_course.name)
                edit_course.description = course_data.get(
                    'description', edit_course.description)
                edit_course.requirements = course_data.get(
                    'requirements', edit_course.requirements)
                edit_course.access_link = course_data.get(
                    'access_link', edit_course.access_link)
                edit_course.save()

        for course in instance.courses.all():
            if str(course.course_id) not in [course_data.get('course_id') for course_data in courses]:
                course.delete()

        return instance

class TrackSerializerAnonymous(serializers.ModelSerializer):
    class Meta:
        model = Track
        fields = ['track_id', 'name', 'description']

    def update(self):
        instance = self.instance
        instance.name = self.validated_data.get('name', instance.name)
        instance.description = self.validated_data.get(
            'description', instance.description)
        instance.save()
        return instance


class CreateCohortSerializer(serializers.Serializer):
    name = serializers.CharField(max_length=30)
    start_date = serializers.DateTimeField(format='%Y-%m-%d %H:%M:%S', default_timezone=pytz.utc)
    end_date = serializers.DateTimeField(format='%Y-%m-%d %H:%M:%S', default_timezone=pytz.utc)
    apply_start_date = serializers.DateTimeField(format='%Y-%m-%d %H:%M:%S', default_timezone=pytz.utc)
    apply_end_date = serializers.DateTimeField(format='%Y-%m-%d %H:%M:%S', default_timezone=pytz.utc)
    tracks = serializers.PrimaryKeyRelatedField(
        many=True, queryset=Track.objects.all())

    def create(self, validated_data):
        try:
            import api.tasks as tasks
            tracks_data = validated_data.pop('tracks')
            cohort = Cohort.objects.create(
                **validated_data, status=COHORT_STATUS.UPCOMING.value)
            # cohort.schedule_create()
            for track_data in tracks_data:
                track = Track.objects.get(track_id=track_data.track_id)
                new_track = Track.objects.create(
                    name=track.name, description=track.description, cohort=cohort, parent=track)
                for course in track.courses.all():
                    Course.objects.create(
                        name=course.name, description=course.description, track=new_track, order=course.order,
                        access_link=course.access_link, requirements=course.requirements)
            return cohort
        except Exception as e:
            cohort.delete()
            raise serializers.ValidationError({"message":"Error creating cohort \U0001F636"})

    # validate that a cohort with the same name does not exist
    def validate(self, data):
        if Cohort.objects.filter(name=data['name']).exists():
            raise serializers.ValidationError(
                { "message": "A cohort with this name already exists \U0001F636"})

        start_date = data.get('start_date')
        end_date = data.get('end_date')
        apply_start_date = data.get('apply_start_date')
        apply_end_date = data.get('apply_end_date')
        if start_date > end_date:
            raise serializers.ValidationError(
                { "message" : "Start date cannot be after end date \U0001F636"})
        if apply_start_date > apply_end_date:
            raise serializers.ValidationError(
                {"message":"Application start date cannot be after application end date \U0001F636"})
        if apply_start_date > start_date:
            raise serializers.ValidationError(
                {"message":"Application start date cannot be after cohort start date \U0001F636"})
        if apply_end_date > end_date:
            raise serializers.ValidationError(
                {"message":"Application end date cannot be after cohort end date \U0001F636"})
        if start_date < timezone.now():
            raise serializers.ValidationError(
                {"message":"Start date cannot be in the past \U0001F636"})
        if apply_start_date < timezone.now():
            raise serializers.ValidationError(
                {"message":"Application start date cannot be in the past \U0001F636"})

        # validate that the cohort does not overlap with another cohort
        cohorts = Cohort.objects.all()
        for cohort in cohorts:
            if (cohort.start_date <= start_date <= cohort.end_date) or (cohort.start_date <= end_date <= cohort.end_date):
                raise serializers.ValidationError(
                    {"message":"Cohort cannot overlap with another cohort \U0001F636"})
        return super(CreateCohortSerializer, self).validate(data)
    
    def to_representation(self, instance):
        representation = super().to_representation(instance)
        return format_tz_repr(instance, representation)


class CohortSerializer(serializers.Serializer):
    cohort_id = serializers.UUIDField(read_only=True)
    name = serializers.CharField(max_length=30)
    start_date = serializers.DateTimeField()
    end_date = serializers.DateTimeField()
    apply_start_date = serializers.DateTimeField()
    apply_end_date = serializers.DateTimeField()
    duration = serializers.IntegerField(read_only=True)
    tracks = serializers.PrimaryKeyRelatedField(
        many=True, queryset=Track.objects.all())
    status = serializers.ChoiceField(
        [(status.value, status.name) for status in COHORT_STATUS])

    def update(self):
        instance = self.instance
        validated_data = self.validated_data
        if instance.status == COHORT_STATUS.ACTIVE.value and instance.start_date != validated_data.get('start_date', instance.start_date):
            raise serializers.ValidationError(
                {"message": "You can't change the start date of a live cohort \U0001F636"})
        previous_start_date = instance.start_date
        previous_end_date = instance.end_date

        instance.name = validated_data.get('name', instance.name)
        instance.start_date = validated_data.get(
            'start_date', instance.start_date)
        instance.end_date = validated_data.get(
            'end_date', instance.end_date)

        # schedule instance update if the start date has changed
        if instance.start_date != previous_start_date or instance.end_date != previous_end_date:
            instance.schedule_update()

        instance.apply_start_date = validated_data.get(
            'apply_start_date', instance.apply_start_date)
        instance.apply_end_date = validated_data.get(
            'apply_end_date', instance.apply_end_date)
        instance.status = validated_data.get('status', instance.status)
        instance.save()

        tracks = validated_data.get('tracks', [])
        track_ids = [track.track_id for track in tracks]
        existing_tracks = instance.tracks.all()

        for track in existing_tracks:
            if track.track_id not in track_ids:
                track.delete()

        for track_data in tracks:
            track_id = track_data.track_id
            if not Track.objects.filter(track_id=track_id, cohort=instance).exists():
                track = Track.objects.get(track_id=track_id)
                Track.objects.create(
                    name=track.name, description=track.description, cohort=instance, parent=track)
        return instance

    def validate(self, data):
        start_date = data.get('start_date')
        end_date = data.get('end_date')
        apply_start_date = data.get('apply_start_date')
        apply_end_date = data.get('apply_end_date')
        # cant change the start date of a live cohort
        if self.instance.status == COHORT_STATUS.ACTIVE.value and start_date != self.instance.start_date:
            raise serializers.ValidationError(
                {"message": "You can't change the start date of a live cohort \U0001F636"})
        if start_date > end_date:
            raise serializers.ValidationError(
                {"message": "Start date cannot be after end date \U0001F636"})
        if apply_start_date > apply_end_date:
            raise serializers.ValidationError(
                {"message": "Application start date cannot be after application end date \U0001F636"})
        if apply_start_date > start_date:
            raise serializers.ValidationError(
                {"message": "Application start date cannot be after cohort start date \U0001F636"})
        if apply_end_date > end_date:
            raise serializers.ValidationError(
                {"message": "Application end date cannot be after cohort end date \U0001F636"})
        if start_date < timezone.now():
            raise serializers.ValidationError(
                {"message": "Start date cannot be in the past \U0001F636"})
        # validate that the cohort does not overlap with another cohort
        cohorts = Cohort.objects.exclude(
            cohort_id=self.instance.cohort_id).all()
        for cohort in cohorts:
            if (cohort.start_date <= start_date <= cohort.end_date) or (cohort.start_date <= end_date <= cohort.end_date):
                raise serializers.ValidationError(
                    {"message": "Cohort cannot overlap with another cohort \U0001F636"})
        return super(CohortSerializer, self).validate(data)

def format_tz_repr(instance, representation):
    utc_plus_one = pytz.timezone('Africa/Lagos')
    for field in instance._meta.get_fields():
        value = getattr(instance, field.name, None)
        if isinstance(value, datetime) and value is not None:
            representation[field.name] = value.astimezone(utc_plus_one).isoformat()
    return representation

class OpenCohortSerializer(serializers.ModelSerializer):
    tracks = TrackSerializer(many=True, read_only=True)

    class Meta:
        model = Cohort
        fields = '__all__'
    
    def to_representation(self, instance):
        representation = super().to_representation(instance)
        return format_tz_repr(instance, representation)

class TrackSerializer2(serializers.ModelSerializer):
    class Meta:
        model = Track
        fields = ['track_id', 'name']

class ApplicationSerializer2(serializers.ModelSerializer):
    track = TrackSerializer2()
    user = UserSerializer()
    class Meta:
        model = Applications
        fields = ['applicant_id', 'user', 'reason', 'referral', 'skills', 'purpose',
                  'education', 'submission_date', 'review_date', 'role', 'track', 'cohort', 'status', 'file']


class ApplicationSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    track = serializers.PrimaryKeyRelatedField(
        queryset=Track.objects.all().values('track_id', 'cohort__apply_end_date'))

    class Meta:
        model = Applications
        fields = ['applicant_id', 'user', 'reason', 'referral', 'skills', 'purpose',
                  'education', 'submission_date', 'review_date', 'role', 'track', 'cohort', 'status', 'file']

    def create(self, validated_data):
        validated_data = self.validated_data
        print(validated_data['user']['email'],
              validated_data['track']['track_id'], 'validated data ')
        user_data = validated_data.pop('user')
        track_id = validated_data.pop('track').get('track_id')
        track = Track.objects.select_related('cohort').get(track_id=track_id)
        user_data_email = user_data.pop('email')
        User = get_user_model()
        try:
            user = User.objects.get(email=user_data_email)
        except User.DoesNotExist:
            user = User.objects.create_user(email=user_data_email, **user_data)
        application = Applications.objects.create(
            user=user, cohort=track.cohort, track=track, **validated_data)
        return application

    def get_attachment(self, instance):
        if instance.file:
            return instance.file.url
        return None

    def validate(self, data):
        logger.info(data, 'data')
        track_apply_end_date = data.get('track').get('cohort__apply_end_date')
        if track_apply_end_date < timezone.now():
            raise serializers.ValidationError(
                {"message":"Application deadline has passed \U0001F636"})
        return super().validate(data)

    def save(self, **kwargs):
        self.instance = super().save(**kwargs)
        # self.instance.user.save()
        return self.instance


class CreateApplicationSerializer(serializers.Serializer):
    first_name = serializers.CharField(max_length=30)
    last_name = serializers.CharField(max_length=30)
    email = serializers.EmailField()
    gender = serializers.ChoiceField(
        [(gender.value, gender.name) for gender in GENDER])
    country = serializers.CharField(max_length=30)
    phone_number = serializers.CharField(max_length=11)
    reason = serializers.CharField()
    referral = serializers.CharField(max_length=100)
    skills = serializers.CharField(max_length=100)
    purpose = serializers.CharField()
    education = serializers.ChoiceField(
        [(education.value, education.name) for education in EDUCATION])
    role = serializers.ChoiceField([(role.value, role.name) for role in ROLE])
    track_id = serializers.UUIDField()
    file = serializers.FileField(required=False, use_url=True, allow_null=True)

    def create(self, validated_data):
        validated_data = self.validated_data
        track_id = validated_data.pop('track_id')
        track = Track.objects.select_related('cohort').get(track_id=track_id)
        first_name = validated_data.pop('first_name')
        last_name = validated_data.pop('last_name')
        email = validated_data.pop('email')
        gender = validated_data.pop('gender')
        country = validated_data.pop('country')
        phone_number = validated_data.pop('phone_number')

        User = get_user_model()
        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            user = User.objects.create_user(first_name=first_name, last_name=last_name, email=email,
                                            gender=gender, country=country, phone_number=phone_number)
        application = Applications.objects.create(
            user=user, cohort=track.cohort, track=track, status=APPLICATION_STATUS.PENDING.value, **validated_data)
        return application

    def validate(self, data):
        if data.get('track_id') is None:
            raise serializers.ValidationError({"message":"Track ID is required to apply \U0001F636"})
        if data.get('role') == ROLE.ADMIN.value:
            raise serializers.ValidationError({"message":"You can't apply as an admin \U0001F636"})
        track_apply_end_date = Track.objects.select_related('cohort').get(
            track_id=data.get('track_id')).cohort.apply_end_date
        if track_apply_end_date < timezone.now():
            raise serializers.ValidationError(
                {"message":"Application deadline has passed \U0001F636"})
        # you can only apply once to once cohort
        if Applications.objects.filter(user__email=data.get('email'), cohort__apply_end_date__gte=timezone.now()).exists():
            raise serializers.ValidationError(
                {"message":"You have already applied for this cohort \U0001F636"})
        return super(CreateApplicationSerializer, self).validate(data)

    def to_representation(self, instance):
        return {
            "message": "Application submitted successfully",
        }


class ReviewApplicationSerializer(serializers.Serializer):
    status = serializers.ChoiceField(
        [(status.value, status.name) for status in APPLICATION_STATUS])

    def validate(self, data):
        if data.get('status') == APPLICATION_STATUS.PENDING.value:
            raise serializers.ValidationError(
                {"message":"You can't set the status to pending \U0001F636"})
        return super(ReviewApplicationSerializer, self).validate(data)


class MentorSerializer(serializers.ModelSerializer):
    user = UserSerializer()
    track = serializers.PrimaryKeyRelatedField(queryset=Track.objects.all())

    class Meta:
        model = Mentors
        fields = ['mentor_id', 'user', 'track']


class GetMentorSerializer(serializers.Serializer):
    full_name = serializers.CharField(max_length=50)
    email = serializers.EmailField()
    bio = serializers.CharField(max_length=500, allow_blank=True)
    track = serializers.SerializerMethodField()
    cohort = serializers.SerializerMethodField()
    mentees = serializers.SerializerMethodField()
    profile_picture = serializers.ImageField(required=False, allow_null=True)

    # convert a mentor model to the required format
    def to_representation(self, instance):
        representation = {}
        representation['full_name'] = f"{instance.user.first_name} {instance.user.last_name}"
        representation['email'] = instance.user.email
        representation['bio'] = instance.user.bio
        representation['track'] = self.get_track(instance)
        representation['cohort'] = self.get_cohort(instance)
        representation['mentees'] = self.get_mentees(instance)
        representation['profile_picture'] = self.get_profile_picture(instance)
        return representation

    def get_profile_picture(self, instance):
        if instance.user.profile_picture:
            return instance.user.profile_picture.url
        return None

    def get_track(self, instance):
        if instance.track:
            return {
                'track_id': instance.track.track_id,
                'name': instance.track.name,
                'enrolled_count': instance.track.enrolled_count
            }
        return None

    def get_cohort(self, instance):
        if instance.track and instance.track.cohort:
            return {
                'cohort_id': instance.track.cohort.cohort_id,
                'name': instance.track.cohort.name,
                'cohort_duration': instance.track.cohort.duration
            }
        return None

    def get_mentees(self, instance):
        mentees = []
        for mentee in instance.mentees.all():
            mentees.append({
                'user_id': mentee.user.user_id,
                'full_name': mentee.user.first_name + " " + mentee.user.last_name,
                'profile_picture': mentee.user.profile_picture.url if mentee.user.profile_picture else None, 
                'email': mentee.user.email,
                'bio': mentee.user.bio,	})
        return mentees


class GetStudentSerializer(serializers.Serializer):
    full_name = serializers.CharField(max_length=50)
    email = serializers.EmailField()
    bio = serializers.CharField(max_length=500, allow_blank=True)
    mentor = serializers.SerializerMethodField()
    track = serializers.SerializerMethodField()
    cohort = serializers.SerializerMethodField()
    profile_picture = serializers.ImageField(required=False)

    # convert a student model to the required format
    def to_representation(self, instance):

        representation = {}
        representation['full_name'] = f"{instance.user.first_name} {instance.user.last_name}"
        representation['email'] = instance.user.email
        representation['bio'] = instance.user.bio
        representation['mentor'] = self.get_mentor(instance)
        representation['track'] = self.get_track(instance)
        representation['cohort'] = self.get_cohort(instance)
        representation['profile_picture'] = self.get_profile_picture(instance)
        representation['progress'] = instance.course_progress
        return representation

    def get_profile_picture(self, instance):
        if instance.user.profile_picture:
            return instance.user.profile_picture.url
        return None

    def get_mentor(self, instance):
        if instance.mentor:
            return {
                'mentor_id': instance.mentor.user.user_id,
                'full_name': f"{instance.mentor.user.first_name} {instance.mentor.user.last_name}",
                'email': instance.mentor.user.email,
                'bio': instance.mentor.user.bio,
                'profile_picture': instance.mentor.user.profile_picture.url if instance.mentor.user.profile_picture else None,
            }
        return None

    def get_track(self, instance):
        if instance.track:
            return {
                'track_id': instance.track.track_id,
                'name': instance.track.name,
                'enrolled_count': instance.track.enrolled_count
            }
        return None

    def get_cohort(self, instance):
        if instance.track and instance.track.cohort:
            return {
                'cohort_id': instance.track.cohort.cohort_id,
                'name': instance.track.cohort.name,
                'cohort_duration': instance.track.cohort.duration
            }
        return None


class GetLatestTrackSerializer(serializers.Serializer):
    track_id = serializers.UUIDField()


class UpdateUserProfileSerializer(serializers.Serializer):
    bio = serializers.CharField(max_length=50, allow_blank=True)


class ReportSubmitSerializer(serializers.Serializer):
    student_id = serializers.UUIDField()
    question_1 = serializers.CharField(max_length=200)
    question_2 = serializers.CharField(max_length=200)
    question_3 = serializers.CharField(max_length=200)


class ReportFeedbackSerializer(serializers.Serializer):
    mentor_id = serializers.UUIDField()
    mentor_feedback = serializers.CharField(max_length=200)


class ReportSerializer(serializers.Serializer):
    student_id = serializers.UUIDField()
    question_1 = serializers.CharField(max_length=200)
    question_2 = serializers.CharField(max_length=200)
    question_3 = serializers.CharField(max_length=200)

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        representation['student_id'] = instance.student.user_id
        representation['full_name'] = f"{instance.student.first_name} {instance.student.last_name}"
        representation['profile_picture'] = instance.student.profile_picture.url if instance.student.profile_picture else None
        representation['report_id'] = instance.report_id
        representation['age'] = instance.calculate_age()
        representation['mentor_feedback'] = instance.mentor_feedback
        return representation

    def create(self, validated_data):
        from .services.CohortService import GetLatestCohort
        student_id = validated_data.pop('student_id')
        latest_cohort = GetLatestCohort().get_student(student_id)
        if not latest_cohort:
            raise serializers.ValidationError(
                {"message":"Student is not enrolled in any cohort \U0001F622"})
        report = Report.objects.create(cohort=latest_cohort,
                                       student_id=student_id,
                                       **validated_data)
        report.save()
        return report

    def update(self, instance, validated_data):
        instance.mentor_feedback = validated_data.get(
            'mentor_feedback', instance.mentor_feedback)
        instance.save()
        return instance


class GetLatestCohortSer(serializers.Serializer):
    cohort_id = serializers.UUIDField()


class SubmitTodoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Todo
        fields = ['todo_id', 'summary', 'course', 'student', 'document']

    def create(self, validated_data):
        try:
            todo = Todo.objects.get(
                student_id=validated_data.get("student"),
                course_id=validated_data.get("course"),
            )

            if todo and todo.feedback == TODO_FEEDBACK.PASSED:
                raise serializers.ValidationError(
                    {"message":"Todo already exists for this student and course \U0001F636"}
                )
            elif todo and (not todo.feedback or todo.feedback == TODO_FEEDBACK.FAILED):
                todo.summary = validated_data.get("summary")
                todo.document = validated_data.get("document")
                todo.feedback = None
                todo.status = TODO_STATUS.PENDING.value
                todo.save()
                return todo
        except Todo.DoesNotExist:
            todo = Todo.objects.create(
                status=TODO_STATUS.PENDING.value, **validated_data)
            return todo

    def validate(self, data):
        try:
            course = Course.objects.get(course_id=data['course'].course_id)
            from .services.CohortService import GetLatestCohort
            student_id = data['student'].user_id
            latest_cohort = GetLatestCohort().get_student(student_id)
            if not latest_cohort:
                raise serializers.ValidationError(
                    {"message":"Student is not enrolled in any cohort \U0001F622"})
            return data
        except Course.DoesNotExist:
            raise serializers.ValidationError({"message":"Course does not exist \U0001F622"})

    def to_representation(self, instance):
        repr = super().to_representation(instance)
        repr['status'] = instance.status
        repr['feedback'] = instance.feedback
        return repr


class TodoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Todo
        fields = ['todo_id', 'summary', 'course',
                  'status', 'student', 'feedback', 'document']

    def create(self, validated_data):
        try:
            todo = Todo.objects.get(
                student_id=validated_data.get("student"),
                course_id=validated_data.get("course"),
            )

            if todo and todo.feedback == TODO_FEEDBACK.PASSED:
                raise serializers.ValidationError(
                    {"message":"Todo already exists for this student and course \U0001F636"}
                )
            elif todo and (not todo.feedback or todo.feedback == TODO_FEEDBACK.FAILED):
                todo.summary = validated_data.get("summary")
                todo.document = validated_data.get("document")
                todo.feedback = None
                todo.status = TODO_STATUS.PENDING.value
                todo.save()
                return todo
        except Todo.DoesNotExist:
            validated_data.pop("status")
            todo = Todo.objects.create(
                status=TODO_STATUS.PENDING.value, **validated_data)
            return todo

    def validate(self, data):
        # ourseid from course object in data
        try:
            course = Course.objects.get(course_id=data['course'].course_id)
            from .services.CohortService import GetLatestCohort
            student_id = data['student'].user_id
            latest_cohort = GetLatestCohort().get_student(student_id)
            if not latest_cohort:
                raise serializers.ValidationError(
                    {"message":"Student is not enrolled in any cohort \U0001F622"})
            return data
        except Course.DoesNotExist:
            raise serializers.ValidationError({"message":"Course does not exist \U0001F622"})


class CourseSerializer_C(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = ['course_id', 'name', 'description',
                  'requirements', 'access_link']

    def to_representation(self, instance):
        repr_ = super().to_representation(instance)
        repr_['order'] = instance.order
        user_id = self.context['user_id']
        if instance.can_view(user_id):
            repr_['description'] = instance.description
            repr_['requirements'] = instance.requirements
            repr_['access_link'] = instance.access_link
            repr_['can_view'] = True
            repr_['todo'] = instance.get_todo(user_id)
        else:
            repr_['description'] = "You have not unlocked this course yet"
            repr_['requirements'] = ""
            repr_['access_link'] = ""
            repr_['can_view'] = False
        return repr_


class TrackSerializer_C(serializers.ModelSerializer):
    def __init__(self, *args, **kwargs):
        user_id = kwargs.pop('user_id', None)
        super().__init__(*args, **kwargs)
        if user_id is not None:
            self.context['user_id'] = user_id

    courses = CourseSerializer_C(many=True)

    # order courses by order number
    def to_representation(self, instance):
        repr_ = super().to_representation(instance)
        repr_['courses'] = sorted(
            repr_['courses'], key=lambda x: x['order'])
        return repr_

    class Meta:
        model = Track
        fields = ['track_id', 'name', 'description', 'courses']


class UpdateProfilePictureSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['profile_picture']

    def update(self, instance, validated_data):
        instance.profile_picture = validated_data.get(
            'profile_picture', instance.profile_picture)
        instance.save()
        return instance


class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)
    new_password_confirm = serializers.CharField(required=True)


class BlockerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Blocker
        fields = ['blocker_id', 'track', 'user', 'description', 'title', 'status', 'created_at' ]

    def create(self, validated_data):
        track_id = validated_data.get('track')
        user_id = validated_data.get('user')
        status = validated_data.pop('status')
        try:
            student = Students.objects.get(user=user_id, track=track_id)
            if not student:
                raise serializers.ValidationError(
                    {"message":"Student does not exist in this track and cannot raise a blocker \U0001F636"})
            # check if cohort has ended for track
            cohort = Cohort.objects.get(tracks=track_id, end_date__gte=timezone.now())
            if not cohort:
                raise serializers.ValidationError(
                    {"message":"Track has ended and cannot raise a blocker \U0001F636"})
            if cohort and cohort.start_date > timezone.now():
                raise serializers.ValidationError(
                    {"message":"Track has not started and cannot raise a blocker \U0001F636"})

            blocker = Blocker.objects.create(status = 0, **validated_data)
            return blocker
        except Students.DoesNotExist:
            raise serializers.ValidationError(
                {"message":"Student does not exist in this track and cannot raise a blocker \U0001F636"})
        except Cohort.DoesNotExist:
            raise serializers.ValidationError(
                {"message":"Track has ended and cannot raise a blocker \U0001F636"})
    
    def update(self, instance, validated_data):
        user_id = validated_data.get('user')            
        return super().update(instance, validated_data)
    
    def to_representation(self, instance):
        repr_ = super().to_representation(instance)
        repr_['user_name'] = instance.user.first_name + " " + instance.user.last_name
        return repr_

class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'

    def create(self, validated_data):
        blocker_id = validated_data.get('blocker')
        # change blocker id from string to uuid
        # blocker_id = uuid.UUID(blocker_id)
        try:
            print(type(blocker_id))
            track = Track.objects.get(blockers=blocker_id)
            if not track:
                raise serializers.ValidationError(
                    {"message":"Blocker does not exist \U0001F636"})
            try:
                student = Students.objects.get(user=validated_data.get('user'), track=track)
            except Students.DoesNotExist:
                mentor = Mentors.objects.get(user=validated_data.get('user'), track=track)
            except Mentors.DoesNotExist:
                raise serializers.ValidationError(
                    {"message":"User is not a student or mentor in this track \U0001F636"})
            comment = Comment.objects.create(**validated_data)
            return comment
        except Track.DoesNotExist:
            raise serializers.ValidationError(
                {"message":"Blocker does not exist \U0001F636"})
    
    def to_representation(self, instance):
        repr_ = super().to_representation(instance)
        repr_['sender_name'] = instance.user.first_name + " " + instance.user.last_name
        return repr_
    

class ChangeMentorSerializer(serializers.Serializer):
    student_id = serializers.UUIDField(required=True)
    mentor_id = serializers.UUIDField(required=True)
    track_id = serializers.UUIDField(required=True)

class SendAnyEmailSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)
    subject = serializers.CharField(required=True)
    message = serializers.CharField(required=True)

class ReorderTrackCoursesSerializer(serializers.Serializer):
    courses = serializers.ListField(child=serializers.UUIDField())