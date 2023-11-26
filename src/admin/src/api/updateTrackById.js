import  urls  from "../constant/urls"

async function updateTrackById(id, trackDetails) {
    const url = urls.getAllTracks + id;
    const res = await fetch(url, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
        body: JSON.stringify(trackDetails),
    });
    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default updateTrackById;