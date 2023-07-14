export  interface currentCohort {
    data: Array<{
        apply_end_date: string,
        apply_start_date: string,
        cohort_id: string,
        duration: number,
        end_date: string,
        name: string,
        start_date: string,
        status: number,
        tracks: Array<{
            description: string,
            name: string,
            track_id: string
        }>,

    }> 
}

export  interface allApplicationList {
    sucessful: boolean,
    responseCode: number,
    message: string | null,
    data: Array<{
        chorstId: string,
        name: string
    }> 
}


export interface applicationResponseType {
    first_name: string | undefined,
    last_name: string | undefined ,
    email: string | undefined,
    education: number | undefined,
    gender: number | undefined,
    phone_number: string | undefined,
    country: string | undefined,
    skills: string | undefined,
    purpose: string | undefined,
    role: number | undefined,
    track_id: string | undefined,
    reason: string | undefined,
    referral: string | undefined,
}