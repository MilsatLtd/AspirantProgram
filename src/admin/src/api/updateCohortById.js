import  urls  from "../constant/urls"

async function updateCohortById(id, cohortDetails) {
    const url = urls.getAllCohorts + id;
    const res = await fetch(url, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
        body: JSON.stringify(cohortDetails),
    });
    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default updateCohortById;