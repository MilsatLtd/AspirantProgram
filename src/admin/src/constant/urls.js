
const API_ENDPOINT = "https://aspirant-api.milsat.africa/api/";

const urls = {
    getAllCohorts: `${API_ENDPOINT}cohorts/`,
    getAllApplications: `${API_ENDPOINT}applications/`,
    getAllTracks: `${API_ENDPOINT}tracks/`,
    login: `${API_ENDPOINT}auth/login`,
    reviewApplication: `${API_ENDPOINT}applications/review/`,

}

export default urls;
