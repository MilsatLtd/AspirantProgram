from django.db import models
from django.contrib.auth import password_validation
from django.contrib.auth.models import AbstractUser, BaseUserManager, PermissionsMixin
from django.contrib.auth.models import Group, Permission
import uuid
from django.contrib.auth.hashers import make_password, check_password
from django.core.validators import MaxValueValidator, MinValueValidator
from django.utils import timezone
from django.core.exceptions import ValidationError


# Create a user mode with fields for
class UserManager(BaseUserManager):
    def create_user(self, email, **extra_fields):
        """Creates and saves a new user"""
        if not email:
            raise ValueError('Users must have an email address')
        email = self.normalize_email(email)
        user = self.model(email=email, username=email, **extra_fields)
        user.set_password(extra_fields['phone_number'])
        user.password2 = make_password(extra_fields['phone_number'])
        user.save(using=self._db)
        return user

    def create_superuser(self, email, **extra_fields):
        """Creates and saves a new superuser"""
        user = self.create_user(email, **extra_fields)
        user.is_superuser = True
        user.is_staff = True
        user.save(using=self._db)
        return user


def unique_profile_picture(instance, filename):
    return 'profile_pictures/{0}_{1}'.format(instance.user_id, filename)


class User(AbstractUser):
    _password2 = None

    GENDER_CHOICES = (
        (0, 'Male'),
        (1, 'Female')
    )
    user_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    email = models.EmailField(max_length=70, unique=True)
    password2 = models.CharField(max_length=128, default='')
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    gender = models.IntegerField(choices=GENDER_CHOICES)
    country = models.CharField(max_length=30)
    phone_number = models.CharField(max_length=11)
    bio = models.TextField(blank=True, max_length=350, default='')
    profile_picture = models.ImageField(
        upload_to=unique_profile_picture, blank=True, null=True)
    objects = UserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['first_name', 'last_name',
                       'gender', 'country', 'phone_number', 'bio']

    def save(self, *args, **kwargs):
        self.username = self.email
        super(User, self).save(*args, **kwargs)

    def set_password2(self, raw_password):
        self.password2 = make_password(raw_password)
        self._password2 = raw_password

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        if self._password is not None:
            password_validation.password_changed(self._password, self)
            self._password = None
        if self._password2 is not None:
            password_validation.password_changed(self._password2, self)
            self._password2 = None

    def check_password(self, raw_password):
        """
        Return a boolean of whether the raw_password was correct. Handles
        hashing formats behind the scenes.
        """
        def setter(raw_password):
            self.set_password(raw_password)
            # Password hash upgrades shouldn't be considered password changes.
            self._password = None
            self.save(update_fields=["password"])

        def setter2(raw_password):
            self.set_password2(raw_password)
            # Password hash upgrades shouldn't be considered password changes.
            self._password2 = None
            self.save(update_fields=["password2"])

        if check_password(raw_password, self.password, setter):
            if self.is_superuser:
                return True, 0
            return True, 2
        elif check_password(raw_password, self.password2, setter2):
            return True, 1
        return False, None


def validate_file_size(value):
    filesize = value.size
    if filesize > 5 * 1024 * 1024:
        raise ValidationError(
            "The maximum file size that can be uploaded is 5MB.")


def unique_application_filename(instance, filename):
    name = 'MAP-Uploads/application_files/' + str(instance.applicant_id) + '_' + filename
    print(name)
    return name


class Applications(models.Model):
    APPLICATION_STATUS = ((0, 'Pending'), (1, 'Accepted'), (2, 'Rejected'))
    EDUCATION_CHOICES = ((0, 'High School'),
                         (1, 'Undergraduate'), (2, 'Graduate'))
    ROLE_CHOICES = ((0, 'Admin'), (1, 'Mentor'), (2, 'Student'))

    applicant_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    reason = models.TextField(max_length=350)
    referral = models.CharField(max_length=50)
    skills = models.TextField(max_length=350)
    purpose = models.TextField(max_length=350)
    education = models.IntegerField(choices=EDUCATION_CHOICES)
    submission_date = models.DateTimeField(auto_now_add=True)
    review_date = models.DateTimeField(blank=True, null=True)
    status = models.IntegerField(choices=APPLICATION_STATUS)
    role = models.IntegerField(choices=ROLE_CHOICES)
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='applications')
    track = models.ForeignKey(
        'Track', on_delete=models.CASCADE, related_name='applications')
    cohort = models.ForeignKey(
        'Cohort', on_delete=models.CASCADE, related_name='applications')
    file = models.FileField(
        upload_to=unique_application_filename, validators=[validate_file_size], blank=False, null=True)


class Track(models.Model):
    track_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    name = models.TextField(blank=False, default='')
    description = models.TextField(blank=True, default='')
    enrolled_count = models.IntegerField(default=0)
    cohort = models.ForeignKey(
        'Cohort', on_delete=models.CASCADE, null=True,  blank=True, related_name='tracks')
    parent = models.ForeignKey(
        'self', on_delete=models.CASCADE, null=True, blank=True, related_name='children')

    def __str__(self):
        return self.name


class Course(models.Model):
    course_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True, default='')
    requirements = models.TextField(blank=True, default='')
    access_link = models.URLField(default='https://milsat.africa')
    track = models.ForeignKey(
        'Track', on_delete=models.CASCADE, related_name='courses')
    order = models.IntegerField(default=0)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.order:
            self.order = self.track.courses.count() + 1
        super().save(*args, **kwargs)

    def can_view(self, user_id):
        from .serializers import TodoSerializer
        try:
            if self.order == 1:
                return True
            todo = Todo.objects.get(
                course__track=self.track, course__order=self.order-1, student=user_id)
            return True
        except Todo.DoesNotExist:
            return False

    def get_todo(self, user_id):
        from .serializers import TodoSerializer
        try:
            todo = Todo.objects.get(
                course__track=self.track, course__order=self.order, student=user_id)
            return TodoSerializer(todo).data
        except Todo.DoesNotExist:
            return None


def unique_todo_filename(instance, filename):
    return 'todo_docs/' + str(instance.todo_id) + '_' + filename


class Todo(models.Model):
    todo_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    summary = models.TextField(blank=True, max_length=350, default='')
    submitted_at = models.DateTimeField(auto_now_add=True)
    status = models.TextField(choices=((0, 'Pending'), (1, 'Completed')))
    course = models.ForeignKey(
        'Course', on_delete=models.CASCADE, related_name='todos')
    student = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='todos')
    feedback = models.TextField(
        choices=((0, 'Failed'), (1, 'Passed')), null=True, blank=True)
    document = models.FileField(
        upload_to=unique_todo_filename, null=True, blank=True)


class Cohort(models.Model):
    cohort_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=40)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    apply_start_date = models.DateTimeField()
    apply_end_date = models.DateTimeField()
    status = models.IntegerField(
        choices=((0, 'Active'), (1, 'Inactive'), (2, 'Upcoming')))
    task_id_1 = models.CharField(max_length=100, null=True, blank=True)
    task_id_2 = models.CharField(max_length=100, null=True, blank=True)
    duration = models.PositiveIntegerField(default=0, editable=False)

    def save(self, *args, **kwargs):
        self.duration = round((self.end_date - self.start_date).days / 30)
        super(Cohort, self).save(*args, **kwargs)

    def __str__(self):
        return self.name

    def schedule_create(self):
        import api.tasks as tasks
        time_delta_start = self.start_date - timezone.now()
        update_task = tasks.cohort_apply_to_live.apply_async(
            (self.cohort_id,), countdown=time_delta_start.total_seconds())
        self.task_id_1 = update_task.id

        time_delta_end = self.end_date - timezone.now()
        update_task = tasks.cohort_live_to_end.apply_async(
            (self.cohort_id,), countdown=time_delta_end.total_seconds())
        self.task_id_2 = update_task.id
        self.save()

    def schedule_update(self):
        import api.tasks as tasks
        from map.celery import app
        app.control.revoke(self.task_id_1, terminate=True)
        time_delta_start = self.start_date - timezone.now()
        update_task = tasks.cohort_apply_to_live.apply_async(
            (self.cohort_id,), countdown=time_delta_start.total_seconds())
        self.task_id_1 = update_task.id

        app.control.revoke(self.task_id_2, terminate=True)
        time_delta_end = self.end_date - timezone.now()
        update_task = tasks.cohort_live_to_end.apply_async(
            (self.cohort_id,), countdown=time_delta_end.total_seconds())
        self.task_id_2 = update_task.id
        self.save()


class Students(models.Model):
    student_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='studentship')
    track = models.ForeignKey(
        Track, on_delete=models.CASCADE, related_name='students')
    mentor = models.ForeignKey(
        'Mentors', on_delete=models.CASCADE, related_name='mentees', null=True)
    progress = models.IntegerField(
        default=0, validators=[MinValueValidator(0), MaxValueValidator(100)])

    @property
    def full_name(self):
        return self.user.first_name + ' ' + self.user.last_name

    @property
    def mentor_name(self):
        return self.mentor.user.first_name + ' ' + self.mentor.user.last_name
    
    @property
    def course_progress(self):
        nSubmittedTodos = len(Todo.objects.filter(student=self.user, course__track=self.track))
        nCourses = len(Course.objects.filter(track=self.track))
        return round((nSubmittedTodos/nCourses)*100)


class Mentors(models.Model):
    mentor_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='mentorship')
    track = models.ForeignKey(
        Track, on_delete=models.CASCADE, related_name='mentors')

    @property
    def full_name(self):
        return self.user.first_name + ' ' + self.user.last_name

    @property
    def mentor_user_id(self):
        return self.user.user_id


class Report(models.Model):
    report_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    student = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='reports')
    cohort = models.ForeignKey(
        Cohort, on_delete=models.CASCADE, related_name='reports')
    sumbitted_at = models.DateTimeField(auto_now_add=True)
    question_1 = models.TextField()
    question_2 = models.TextField()
    question_3 = models.TextField()
    mentor_feedback = models.TextField(null=True)

    def calculate_age(self):
        return round((timezone.now() - self.sumbitted_at).seconds / 60)\


class Blocker(models.Model):
    blocker_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='blockers')
    title = models.CharField(max_length=200)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.IntegerField(choices=((0, 'Pending'), (1, 'Resolved')))
    track = models.ForeignKey(
        Track, on_delete=models.CASCADE, related_name='blockers')


class Comment(models.Model):
    comment_id = models.UUIDField(
        primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name='comments')
    blocker = models.ForeignKey(
        Blocker, on_delete=models.CASCADE, related_name='comments')
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

