import  urls  from "../constant/urls"

async function addNewCohort( cohortDetails) {
    const url = urls.getAllCohorts;
    const res = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },     
        body: JSON.stringify(cohortDetails),
    });
    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default addNewCohort;