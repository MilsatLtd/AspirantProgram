import  urls  from "../constant/urls"

async function fetAllTracks() {
    const res = await fetch(urls.getAllTracks, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
    });
    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default fetAllTracks;