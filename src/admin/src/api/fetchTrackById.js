import  urls  from "../constant/urls"

async function fetchTrackById(id) {
    const url = urls.getAllTracks + id;
    const res = await fetch(url, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
    });
    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default fetchTrackById;