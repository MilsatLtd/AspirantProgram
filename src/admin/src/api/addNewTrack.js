import  urls  from "../constant/urls"

async function addNewTrack( trackDetails) {
    const url = urls.getAllTracks;
    const res = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
        body: JSON.stringify(trackDetails),
    });
    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default addNewTrack;