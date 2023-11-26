import { useParams } from "react-router-dom"
import Navbar from "./Navbar"
import Enums from "./constant/enum";
import utils from "./constant/common";
import { Link } from "react-router-dom";
import Applications from "./Application";
import { useQuery, useMutation } from "@tanstack/react-query";
import fetchCohortById from "./api/fetchCohortById";
import updateCohortById from "./api/updateCohortById";

import Loader from "./Loader";

const formatCohort = (cohort) => {

    if (!isNaN(Number(cohort.status))) {
        cohort.status = utils.getEnumKeyByValue(Enums.COHORT_STATUS, cohort.status)

        cohort.start_date = utils.formatDate(cohort.start_date)

        cohort.end_date = utils.formatDate(cohort.end_date)

        cohort.apply_start_date = utils.formatDate(cohort.apply_start_date)

        cohort.apply_end_date = utils.formatDate(cohort.apply_end_date)

    }

    return cohort
}

const formatCohortForUpdate = (cohort, status) => {
    const { task_id_1, task_id_2, tracks, ...updatedCohort } = { ...cohort };
    
    // Check if 'tracks' is defined before mapping
    updatedCohort.tracks = tracks ? tracks.map(track => track.track_id) : [];
    delete updatedCohort.task_id_1;
    delete updatedCohort.task_id_2;
    
    // Provide a default value for 'status' if it is not defined
    updatedCohort.status = status !== undefined ? status : null;
    
    return updatedCohort;
  };
 
function CohortTrack ( { track }) {
    return (
        <div className=" flex gap-5 w-full justify-between">
            <h3 className="p-1 col-start-1">{track.name}</h3>
            <Link to="/">
            <button className="active:bg-black active:text-white p-1 pl-2 pr-2 rounded-xl text-sm bg-white
                text-black border-solid border-2 border-black hover: transition-colors duration-300
                font-semibold shadow-2xl"
            >
                View</button>
            </Link>
        </div>  
    )
}


function CohortDetails () {
    const { cohort_id } = useParams()
    const results = useQuery( ['icohort'], () => fetchCohortById(cohort_id), { staleTime: 1000 * 60 * 5 })
    const newResults = useQuery( ['uncohort'], () => fetchCohortById(cohort_id), { staleTime: 1000 * 60 * 5 })

    const cohort = results?.data ? formatCohort(results.data) : {
        name: "",
        status: "",
        start_date: "",
        end_date: "",
        apply_start_date: "",
        apply_end_date: "",
        tracks: []
    };

    const handleCohortStatusChange = (status) => {
        const updatedCohort = { ...newResults?.data}
        const formatedCohort = formatCohortForUpdate(updatedCohort, status)
        updateCohortById(cohort_id, formatedCohort )
    }

    return (
    <>
    <Navbar  showLinks={true}/>
    <div className="flex">
    <div className="flex gap-5 items-center">
        <h1 className="text-4xl font-semibold m-7">Cohort Details</h1>
        {
            cohort.status === Enums.COHORT_STATUS.LIVE ?
            <button className="border-2 border-black text-black p-4 rounded-md hover:opacity-90"
        onClick={()=>handleCohortStatusChange(Enums.COHORT_STATUS.LIVE)}
        >Start Cohort</button> : null
        }
    </div>
   
    {results.isLoading ? <Loader css1={"flex justify-center items-center"} css2="w-[30px] h-[30px]" /> : null}
    </div>
    <form action="">
        <div className="pl-2">
            <div className="grid grid-cols-2 gap-20">
                <div className="flex flex-col gap-5 ml-5">
                    <label className="font-bold text-xl" htmlFor="cohort_name">Cohort Name</label> 
                    <input className="border-2 border-black rounded-xl p-2 "
                        type="text" name="cohort_name" id="cohort_name" defaultValue={cohort.name}/>

                    <label className="font-bold text-xl" htmlFor="cohort_status">Cohort Status</label>
                    <input className="border-2 border-black rounded-xl p-2 "
                        type="text" name="cohort_status" id="cohort_status" defaultValue={cohort.status}/>

                    <label className="font-bold text-xl" htmlFor="cohort_start_date">Cohort Start Date</label>
                    <input className="border-2 border-black rounded-xl p-2 "
                        type="text" name="cohort_start_date" id="cohort_start_date" defaultValue={cohort.start_date}/>

                    <label className="font-bold text-xl" htmlFor="cohort_end_date">Cohort End Date</label>
                    <input className="border-2 border-black rounded-xl p-2 "
                        type="text" name="cohort_end_date" id="cohort_end_date" defaultValue={cohort.end_date}/>

                    <label className="font-bold text-xl" htmlFor="cohort_apply_start_date">Cohort Apply Start Date</label>
                    <input className="border-2 border-black rounded-xl p-2 "
                        type="text" name="cohort_apply_start_date" id="cohort_apply_start_date" defaultValue={cohort.apply_start_date}/>

                    <label className="font-bold text-xl" htmlFor="cohort_apply_end_date">Cohort Apply End Date</label>
                    <input className="border-2 border-black rounded-xl p-2 "
                        type="text" name="cohort_apply_end_date" id="cohort_apply_end_date" defaultValue={cohort.apply_end_date}/>

                </div>
                <div className="flex flex-col gap-1">
                        <h1 className="text-3xl font-semibold ">Tracks</h1>
                        <div className="grid grid-col-2  w-2/3 ">
                            <div className="col-span-1 flex flex-col gap-8">
                                {cohort.tracks.map((track) => {
                                    return <CohortTrack key={track.track_id} track={track} />
                                })}
                            </div>
                        </div>  
                    </div>
            </div>

            <div className=" col-start-2 col-span-2 pt-5 mt-5">
                <div className="">
                <h1 className="flex text-4xl font-semibold justify-center">Applications</h1>
                <Applications />
                </div>
            </div>
        </div>
    </form>
    
    </>
    )
}

export default CohortDetails
