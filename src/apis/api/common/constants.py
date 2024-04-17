from api.common.enums import ROLE

from datetime import datetime

def format_timestamp(timestamp):
    timestamp = str(timestamp)
    dt = datetime.fromisoformat(timestamp)
    formatted_timestamp = dt.strftime('%B %d, %Y, %I:%M %p')
    return formatted_timestamp

def application_message(application, password):
    cohort_name = str(application.track.cohort.name)
    if 'cohort' not in cohort_name.lower():
        cohort_name = f"{cohort_name} Cohort"
        cohort_name = cohort_name.upper()

    if application.role == ROLE.MENTOR.value:
        role = "Mentor"
    elif application.role == ROLE.STUDENT.value:
        role = "Student"
    
    return {"subject":
            f"Welcome to the Milsat Aspirant Programme!",

            "body":
            f"""
Dear {application.user.first_name},

We're thrilled to inform you that your application for the Milsat Aspirant Programme has been successfully reviewed, and it is with great pleasure that we extend our warmest congratulations on your admission to the {cohort_name} as a {role}.

Your journey with us begins on {format_timestamp(application.track.cohort.start_date)}, and concludes on {format_timestamp(application.track.cohort.end_date)}.

To ensure you make the most of your experience, we have prepared a starter pack for you:

1. Kindly take a moment to fill out this form: https://forms.gle/yttJAz4xSYGVQufp9

2. Proceed to download the Milsat Aspirant Programme mobile application either from the Play Store or via the following link: https://play.google.com/store/apps/details?id=com.milsat.apirant&pcampaignid=web_share

3. Additionally, make sure to download the manual for easy reference as you navigate through the app.
Link to download the manual: https://drive.google.com/file/d/1ZxzoUM5EKpA_cDUOu5fWGtHmtDC3rXZC/view?usp=drive_link

Finally, below are your login credentials for the mobile application:
-Email: {application.user.email}
-Password: {password}

Should you have any questions or require assistance, please don't hesitate to contact us at map.milsat@gmail.com.

Best regards,
MAP Admin.

"""}


