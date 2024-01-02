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
            f"Welcome to the Milsat Aspirant Programme!",

            "body":
            f"""
Hi {application.user.first_name},

Congratulations! We have carefully reviewed your application and we are pleased to inform you that you have been admitted into the Milsat Aspirant Programme for this cohort. We are excited to welcome you to our program and can't wait for you to thrive in your learning phase.

Cohort Name: {application.track.cohort.name}
Cohort starts on {format_timestamp(application.track.cohort.start_date)} and ends on {format_timestamp(application.track.cohort.end_date)}.

To commence your journey, kindly download the Milsat Aspirant Programme application on playstore to get started. 

Download Link: https://play.google.com/store/apps/details?id=com.milsat.apirant&pcampaignid=web_share

Your login details are:
Email: {application.user.email}
Password: {password}

You can login to the mobile app using the above credentials.

If you have any questions or concerns, please don't hesitate to reach out to us at map.milsat@gmail.com.

Best regards.
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