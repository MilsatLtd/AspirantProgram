export interface basicInfo {
    first_name: string | undefined;
    last_name: string | undefined;
    email: string | undefined;
    education: number | undefined;
    gender: number | undefined;
    phone_number: string | undefined;
    role: number | undefined;
    country: string | undefined;
    skills: string | undefined;
    purpose: string | undefined;
    accurate: boolean | undefined;
    terms: boolean | undefined;
  }

export interface reasonInfo {
    cohort: string | undefined;
    track_id: string | undefined;
    file: File | undefined;
    reason: string | undefined;
    referral: string | undefined;
}

export interface enumObjects {
    [key: string]: number;
}



export interface applicationResponseType {
    first_name: string,
    last_name: string,
    email: string,
    education: number,
    gender: number,
    phone_number: string,
    country: string,
    skills: string,
    role: number,
    purpose: string,
    track_id: string,
    reason: string,
    referral: string,
}


export interface applicationFormType {
    postResponse: (form: FormData)  => void;
    passEmail: (email: basicInfo["email"]) => void;
}

export interface applicationInfoType{
    applicationTimeline: {start_date: string, end_date: string}
}


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

export interface tracks {
    details : Array<{
        name: string,
        track_id: string
    }>
}