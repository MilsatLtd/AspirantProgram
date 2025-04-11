from api.common.enums import ROLE

from datetime import datetime

def format_timestamp(timestamp):
    timestamp = str(timestamp)
    dt = datetime.fromisoformat(timestamp)
    formatted_timestamp = dt.strftime('%B %d, %Y, %I:%M %p')
    return formatted_timestamp

def application_message(application, password, isPreviouslyAccepted):
    if isPreviouslyAccepted:
        return application_message_previously_accepted(application)

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

We're thrilled to inform you that your application for the Milsat Aspirant Programme has been successfully reviewed, and it is with great pleasure that we extend our warmest congratulations on your admission to the {cohort_name} cohort as a {role} under the {application.track.name} track.

Your journey with us begins on {format_timestamp(application.track.cohort.start_date)}, and concludes on {format_timestamp(application.track.cohort.end_date)}.

To ensure you make the most of your experience, we have prepared a starter pack for you;
    - Credential to login into the MAP training Portal 
        Username {application.user.email} 
        Password {password}

    - Url to the Training Portal: [MAP Training Portal](https://aspirant.milsat.africa/login)
    - Link to Download Training Curriculum
        Geospatial Data Collection: [Download here](https://drive.google.com/file/d/1zYZUTjGuS217Fl1KTCZgCy0O6ErO7mgP/view?usp=drive_link)
        Fundamental of GIS: [Download here](https://drive.google.com/file/d/1raCiD80j7ujx1RNsfu8D3pbkMZpVOj7k/view?usp=drive_link)

Should you have any questions or require assistance, please don't hesitate to contact us at map.milsat@gmail.com.

Best regards,
MAP Admin.

"""}


def application_message_previously_accepted(application):
    cohort_name = str(application.track.cohort.name)
    if 'cohort' not in cohort_name.lower():
        cohort_name = f"{cohort_name} Cohort"
        cohort_name = cohort_name.upper()

    if application.role == ROLE.MENTOR.value:
        role = "Mentor"
    elif application.role == ROLE.STUDENT.value:
        role = "Student"

    return {"subject":
            f"Welcome back to the Milsat Aspirant Programme!",

            "body":
            f"""
Dear {application.user.first_name},

We're thrilled to inform you that your application for the Milsat Aspirant Programme has been successfully reviewed, and it is with great pleasure that we extend our warmest congratulations on your admission to the {cohort_name} cohort as a {role} under the {application.track.name} track.

Your journey with us begins on {format_timestamp(application.track.cohort.start_date)}, and concludes on {format_timestamp(application.track.cohort.end_date)}.

To ensure you make the most of your experience, we have prepared a starter pack for you;
    - Url to the Training Portal: [MAP Training Portal](https://aspirant.milsat.africa/login)
    - Link to Download Training Curriculum
        Geospatial Data Collection: [Download here](https://drive.google.com/file/d/1zYZUTjGuS217Fl1KTCZgCy0O6ErO7mgP/view?usp=drive_link)
        Fundamental of GIS: [Download here](https://drive.google.com/file/d/1raCiD80j7ujx1RNsfu8D3pbkMZpVOj7k/view?usp=drive_link)

Should you have any questions or require assistance, please don't hesitate to contact us at map.milsat@gmail.com.

Best regards,
MAP Admin.

"""}
    
