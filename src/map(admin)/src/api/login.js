import urls from "../constant/urls"

async function Auth(credentials) {
    const res = await fetch(urls.login, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(credentials),
    });

    if (!res.ok) {
        throw new Error("Network response was not ok");
    }
    return res.json();
}

export default Auth;