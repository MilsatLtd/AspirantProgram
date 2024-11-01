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

We're thrilled to inform you that your application for the Milsat Aspirant Programme has been successfully reviewed, and it is with great pleasure that we extend our warmest congratulations on your admission to the {cohort_name} cohort as a {role}.

Your journey with us begins on {format_timestamp(application.track.cohort.start_date)}, and concludes on {format_timestamp(application.track.cohort.end_date)}.

To ensure you make the most of your experience, we have prepared a starter pack for you;
    - Kindly take a moment to download the curriculum. [Data Collection Curriculum.pdf](https://drive.google.com/file/d/1KIim28hV4skwWjuioM4zVWaGe-do7zYF/view?usp=sharing)
    - To facilitate effective communication and collaboration, we invite you to join our WhatsApp group by clicking on this link [MAP Second Cohort](https://chat.whatsapp.com/GRgsY8bSjU412CmHor26UN).

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

We're thrilled to inform you that your application for the Milsat Aspirant Programme has been successfully reviewed, and it is with great pleasure that we extend our warmest congratulations on your admission to the {cohort_name} cohort as a {role}.

Your journey with us begins on {format_timestamp(application.track.cohort.start_date)}, and concludes on {format_timestamp(application.track.cohort.end_date)}.

To ensure you make the most of your experience, we have prepared a starter pack for you;
    - Kindly take a moment to download the curriculum. [Data Collection Curriculum.pdf](https://drive.google.com/file/d/1KIim28hV4skwWjuioM4zVWaGe-do7zYF/view?usp=sharing)
    - To facilitate effective communication and collaboration, we invite you to join our WhatsApp group by clicking on this link [MAP Second Cohort](https://chat.whatsapp.com/GRgsY8bSjU412CmHor26UN).

Should you have any questions or require assistance, please don't hesitate to contact us at map.milsat@gmail.com.

Best regards,
MAP Admin.

"""}
    
