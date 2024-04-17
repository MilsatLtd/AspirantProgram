import  urls  from "../constant/urls"

async function deleteCohortById(cohort_id) {
    const url = urls.getAllCohorts + `${cohort_id}`;
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

export default deleteCohortById;