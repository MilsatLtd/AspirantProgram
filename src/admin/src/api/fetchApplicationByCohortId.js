import  urls  from "../constant/urls"

async function fetchApplicationByCohortId(cohortId, page){
    const url = urls.getAllApplications + cohortId+`/?page_number=${page}&page_size=40`;
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

export default fetchApplicationByCohortId;