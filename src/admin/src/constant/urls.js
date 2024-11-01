
const API_ENDPOINT = import.meta.env.VITE_APP_API_BASE_URL;

const urls = {
    getAllCohorts: `${API_ENDPOINT}cohorts/`,
    getAllApplications: `${API_ENDPOINT}applications/`,
    getAllTracks: `${API_ENDPOINT}tracks/`,
    login: `${API_ENDPOINT}auth/login`,
    reviewApplication: `${API_ENDPOINT}applications/review/`,

}

export default urls;
