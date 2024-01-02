import  urls  from "../constant/urls"

async function addNewCourseToTrack(id, courseDetails) {
    const url = urls.getAllTracks + "courses/";
    const res = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
        body: JSON.stringify({
            courses: courseDetails,
            track_id: id
        }),
    });
    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default addNewCourseToTrack;