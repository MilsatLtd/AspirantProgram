from api.common.enums import ROLE

from datetime import datetime

def format_timestamp(timestamp):
    timestamp = str(timestamp)
    dt = datetime.fromisoformat(timestamp)
    formatted_timestamp = dt.strftime('%B %d, %Y, %I:%M %p')
    return formatted_timestamp

def application_message(application, password):
    if application.role == ROLE.STUDENT.value:
        role = "student"
    elif application.role == ROLE.MENTOR.value:
        role = "mentor"
    return {"subject":
            f"Acceptance to MAP Cohort",

            "body":
            f"""
Hi {application.user.first_name},

Congratulations, your application to join the {application.track.name} track as a {role} has been accepted.

Cohort Name: {application.track.cohort.name}
Cohort starts on {format_timestamp(application.track.cohort.start_date)} and ends on {format_timestamp(application.track.cohort.end_date)}.

Your login details are:
Email: {application.user.email}
Password: {password}

You can login to the mobile app using the above credentials.

After logging in, change your password to something you can remember.

Regards,
MAP Admin

     """}


{
    "name": "Geospatial Data Scientist",
    "description": "I enjoy building spatial data science applications",
    "courses": [
        {
            "name": "Introduction to Python",
            "description": "You will learn how to use Python for data science",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        },
        {
            "name": "Introduction to PostGIS",
            "description": "You will learn how to use PostGIS for data science",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        },
        {
            "name": "Introduction to QGIS",
            "description": "You will learn how to use QGIS for data science",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        }
    ]
}

{
    "name": "Geospatial Backend Engineer",
    "description": "I enjoy building server-side spatial applications",
    "courses": [
        {
            "name": "Introduction to Python",
            "description": "Link to this course can be found in freecodecamp.com",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        },
        {
            "name": "Introduction to Django",
            "description": "Link to this course can be found in freecodecamp.com",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        },
        {
            "name": "Introduction to PostGIS",
            "description": "Link to this course can be found in freecodecamp.com",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        }
    ]
}

{
    "name": "Geospatial Frontend Engineer",
    "description": "I enjoy building client-side spatial applications",
    "courses": [
        {
            "name": "Introduction to HTML/CSS",
            "description": "Link to this course can be found in freecodecamp.com",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        },
        {
            "name": "Introduction to Javascript",
            "description": "Link to this course can be found in freecodecamp.com",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        },
        {
            "name": "Introduction to React",
            "description": "Link to this course can be found in freecodecamp.com",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        },
        {
            "name": "Introduction to Mapbox",
            "description": "Link to this course can be found in freecodecamp.com",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        },
        {
            "name": "Introduction to Turf.js",
            "description": "Link to this course can be found in freecodecamp.com",
            "requirements": "Able to read and write in English",
            "access_link": "https://milsat.africa"
        }
    ]
}


# Add content to the main page
# 
# "fc29de0f-f23a-4d32-b1f4-77cbdf22a2ce", "3e7cec20-91b4-4810-b7bb-95c3f567439d", "35b17ae7-af0c-4d88-ad09-f317eaba8f13"