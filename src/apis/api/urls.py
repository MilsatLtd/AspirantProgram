from django.urls import path
from .views.TrackViews import *
from .views.CohortViews import *
from .views.ApplicationViews import *
from .views.StudentViews import *
from .views.MentorViews import *
from .views.AuthViews import *
from .views.UserViews import *
from .views.BlockerViews import *
from .views.ReportViews import *
from .views.TodoViews import *

from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

urlpatterns = [
    path("auth/login", TokenObtainPairView.as_view(), name="login"),
    path("auth/refresh", TokenRefreshView.as_view(), name="refresh"),
    path("auth/password/change", ChangePasswordView.as_view(), name="changePassword"),
    path('auth/forgot_password', PasswordReset.as_view(), name='password_reset'),
    path('auth/reset_password/', PasswordResetConfirm.as_view(), name='password_reset_confirm'),
]

urlpatterns += [
    path(
        "users/update/<uuid:user_id>",
        UpdateProfileView.as_view(),
        name="updatetProfile",
    ),
    # update profile picture
    path(
        "users/update/picture/<uuid:user_id>",
        UpdateProfilePictureView.as_view(),
        name="updateProfilePicture",
    ),
    # change password
]

urlpatterns += [
    path("blockers", BlockerListCreateView.as_view(), name="listCreateBlocker"),
    path(
        "blockers/track/<uuid:track_id>", BlockerTrack.as_view(), name="getTrackBlocker"
    ),
    path(
        "blockers/<uuid:blocker_id>",
        BlockerRetrieveUpdateDestroyView.as_view(),
        name="retrieveUpdateDestroyBlocker",
    ),
    path(
        "blockers/comments/<uuid:blocker_id>",
        CommentListCreateView.as_view(),
        name="listCreateComment",
    ),
    path(
        "blockers/comments/update/<uuid:comment_id>",
        CommentRetrieveUpdateDestroyView.as_view(),
        name="retrieveUpdateDestroyComment",
    ),
]

urlpatterns += [
    path("reports/view/<uuid:report_id>", GetReportView.as_view(), name="getReport"),
    path("reports/create", CreateReportView.as_view(), name="createReport"),
    path(
        "reports/mentor/<uuid:mentor_id>",
        ListMentorReportView.as_view(),
        name="listMentorReport",
    ),
    path(
        "reports/feedback/<uuid:report_id>",
        SubmitReportView.as_view(),
        name="submitFeedback",
    ),
    path("reports/", ListReportView.as_view(), name="listReport"),
    path(
        "reports/<uuid:student_id>",
        ListStudentReportView.as_view(),
        name="listStudentReports",
    ),
]

urlpatterns += [
    path("todos/submit", SubmitTodoView.as_view(), name="submitTodo"),
    path("todos/<uuid:todo_id>", GetTodoView.as_view(), name="getTodo"),
    # path("todos/<uuid:todo_id>/review", ReviewTodoView.as_view(), name="reviewTodo"),
]

urlpatterns += [
    path("cohorts/", CreateandListCohort.as_view(), name="createCohort"),
    path(
        "cohorts/<uuid:cohort_id>",
        GetAndUpdateCohortView.as_view(),
        name="getandUpdateCohort",
    ),
    path("cohorts/apply", ApplytoLiveCohortView.as_view(), name="applyToCohort"),
    path("tracks/", CreateandListTrack.as_view(), name="createTrack"),
    path(
        "tracks/<uuid:track_id>",
        GetAndUpdateTrackView.as_view(),
        name="getAndUpdateTrack",
    ),
    path(
        "tracks/cohort/<uuid:cohort_id>",
        GetTrackByCohortView.as_view(),
        name="getTracksByCohort",
    ),
    path("tracks/courses/", AddCourseToTrackView.as_view(), name="addCourseToTrack"),
    path(
        "tracks/delete/<uuid:track_id>", DeleteTrackView.as_view(), name="deleteTrack"
    ),
    # add endpoint to reorder courses
    path(
        "tracks/reorder/<uuid:track_id>",
        ReorderTrackCoursesView.as_view(),
        name="reorderTrackCourses",
    ),
    path("applications/<uuid:cohort_id>/", ListApplication.as_view(), name="ListApplications"),
    path(
        "applications/review/<uuid:applicant_id>",
        ReviewApplicationView.as_view(),
        name="reviewApplication",
    ),
    path(
        "applications/cohorts/open",
        GetOpenApplyCohortView.as_view(),
        name="getOpenApplications",
    ),
    path(
        "applications/stats/<uuid:cohort_id>",
        GetApplicationStatsView.as_view(),
        name="getApplicationStats",
    ),
    path("applications/export/<uuid:cohort_id>/<str:role>",
          ExportApplicationsView.as_view(),
          name='exportApplications'),
    path(
        "students/<uuid:user_id>/<uuid:track_id>",
        GetStudentView.as_view(),
        name="getStudent",
    ),
    path(
        "students/<uuid:user_id>",
        GetStudentByLatestTrackView.as_view(),
        name="getStudent_by_latest_track",
    ),
    path(
        "students/recent/<uuid:user_id>",
        GetStudentLatestTrackView.as_view(),
        name="getLatestTrack",
    ),
    path(
        "students/courses/<uuid:student_id>/<uuid:track_id>",
        GetStudentTrackCoursesView.as_view(),
        name="getStudentTrackCourses",
    ),
    # change student mentor
    path(
        "students/mentor", ChangeStudentMentorView.as_view(), name="changeStudentMentor"
    ),
    path(
        "mentors/<uuid:user_id>/<uuid:track_id>",
        GetMentorView.as_view(),
        name="getMentor",
    ),
    path(
        "mentors/<uuid:user_id>",
        GetMentorByLatestTrackView.as_view(),
        name="getMentor_by_latest_track",
    ),
    path(
        "mentors/recent/<uuid:user_id>",
        GetMentorLatestTrackView.as_view(),
        name="getMentorTrack",
    ),
    path("email", SendAnyEmailView.as_view(), name="sendEmail"),
    path("email_async_test", SendAnyEmailViewAsync.as_view(), name="sendEmailAsyncTest"),
]
