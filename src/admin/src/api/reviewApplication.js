import  urls  from "../constant/urls"

async function reviewApplication(applicant_id, status) {
    const url = urls.reviewApplication + applicant_id;
    const res = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
        body: JSON.stringify({
            status: status,
        }),
    });
    if (!res.ok) {
        const errorResponse = await res.json().catch(() => null);
        throw new Error(errorResponse?.message || "Network response was not ok");
    }
    return res.json();
}

export default reviewApplication;