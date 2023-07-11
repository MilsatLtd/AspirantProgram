import  urls  from "../constant/urls"

async function fetAllCohorts() {
    const res = await fetch(urls.getAllCohorts, 
        {
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

export default fetAllCohorts;