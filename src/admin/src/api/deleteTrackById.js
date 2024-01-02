import  urls  from "../constant/urls"

async function deleteTrackById(track_id) {
    const url = urls.getAllTracks + `delete/${track_id}`;
    const res = await fetch(url, {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
    });
    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default deleteTrackById;