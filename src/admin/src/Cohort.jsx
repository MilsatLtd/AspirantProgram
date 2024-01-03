/* eslint-disable react/prop-types */
import Navbar from "./Navbar";
import { useQuery, useMutation } from "@tanstack/react-query";
import { useState } from "react";
import Modal from "./Modal";
import fetAllCohorts from "./api/fetchAllCohorts";
import Enums from "./constant/enum";
import utils from "./constant/common";
import { Link } from "react-router-dom";
import fetAllTracks from "./api/fetchAllTracks";
import addNewCohort from "./api/addNewCohort";

function Loader() {
    return (
      <div className="flex justify-center items-center">
        <div className="animate-spin rounded-full h-7 w-7 border-t-4 border-b-4 border-blue-500 text-sm ml-10 text-purple-900">map</div>
      </div>
    );
  }
  

// eslint-disable-next-line react/prop-types
function CohortRow( { cohort, details } ) {
    if (details === "TableHeader") {
        return (
            <tr className="flex items-center w-full">
                <th className="flex-1 flex items-start">Cohort Name</th>
                <th className="flex-1  flex items-start">Status</th>
                <th className="flex-1  flex items-start">Timeline</th>
                <th className="flex-1   flex items-start">Details</th>
            </tr>
        );
    }
    else {
        var { name, status } = cohort;
        status = utils.getEnumKeyByValue(Enums.COHORT_STATUS, status)
        const timeline_start = utils.formatDate(cohort.start_date)
        const timeline_end = utils.formatDate(cohort.end_date)
        var timeline = `${timeline_start} - ${timeline_end}`
    }
    return (
        <tr className="flex justify-between w-full">
            <td className="flex-1">{name}</td>
            <td className=" flex-1 flex ">{status}</td>
            <td className=" flex-1 flex">{timeline}</td>
            <td className=" flex-1 flex ">
            <Link to={`/cohorts/${cohort.cohort_id}`} state={cohort}>
                <button 
                className="active:bg-black active:text-white p-2 pl-3 pr-3 rounded-xl text-sm bg-white 
                text-black border-solid border-4 border-black hover: transition-colors duration-300
                font-semibold shadow-2xl">
                View Details
                </button>
            </Link>
            </td>
        </tr>
    );
}


function CohortTable() {
    const [isNewCohortEdit, setIsNewCohortEdit] = useState(false);
    const results = useQuery(["cohorts"], fetAllCohorts);
    const cohorts = results?.data ?? [];

    return (
        <>
        <div>
            <Navbar showLinks={true}/>
            <div className="w-[90%] mx-auto">
            <div className="w-full">
                <div className="header"> 
                <div className="flex items-center justify-between">
                    <div className="flex-1 flex ">
                    <h1 className="flex justify-center my-20 text-5xl leading-5"> Cohorts </h1>
                    {
                    results.isLoading ? <Loader /> : null
                    }
                    </div>
                    
                   
                    <button
                     className=" bg-black text-white font-medium rounded-md flex items-center px-4 py-4"
                     onClick={() => setIsNewCohortEdit(true)}
                     >
                        + Add Cohort
                    </button>
                </div>
                
                
                </div>
                <div className="w-full">
                    <div className="w-full">
                        <table className="grid grid-rows-1 w-full">
                            <thead className="bg-gray-300 text-l ">
                                <CohortRow details="TableHeader"/>
                            </thead>
                            <tbody className="bg-gray-50 text-sm">
                                {cohorts.map((cohort) => (
                                    <CohortRow
                                        key={cohort.cohort_id}
                                        cohort = {cohort}
                                    />
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
         </div>
        </div>
        {
            isNewCohortEdit ? (
            <Modal>
                <NewCohorts  closeEdit={()=>{setIsNewCohortEdit(false)
                    results.refetch()
                }}/>
            </Modal>) : null
        }
        </>
    );
}
export default CohortTable;


function NewCohorts ({closeEdit}) {
    const [cohortName, setCohortName] = useState("")
    const [trackIDs, setTrackIDs] = useState([])
    const [time, setTime] = useState({
        apply_start_date: "00.00",
        apply_end_date: "00.00",
        start_date: "00.00",
        end_date: "00.00",
        })
    const [date, setDate] = useState({
        apply_start_date: "",
        apply_end_date: "",
        start_date: "",
        end_date: "",
        })
    const handleClose = () => {
        closeEdit();
    }
    const results = useQuery(["Tracks"], fetAllTracks);
    const addCohort = useMutation((newCohort) => addNewCohort(newCohort))
    const tracks = results?.data ?? [];
    const allTrackIDs = tracks.map((track)=>( { id: track.track_id, name: track.name}))

    const handleChange = (e) => {
        let { name, value } = e.target;
        setDate((prevState) => ({...prevState, [name]: value}));
    }

    const handleTimeChange = (e) => {
        let { name, value } = e.target;
        setTime((prevState) => ({...prevState, [e.target.name]: e.target.value})); 
    }
    const handleSubmit = (event) => {
        event.preventDefault();
        if(cohortName && trackIDs.length > 0 && date.start_date && date.end_date && date.apply_start_date && date.apply_end_date){
            const cohortDetails = { 
                name: cohortName,
                start_date: utils.formatDateToISO(date.start_date, time.start_date),
                end_date: utils.formatDateToISO(date.end_date, time.end_date),
                apply_start_date: utils.formatDateToISO(date.apply_start_date, time.apply_start_date),
                apply_end_date: utils.formatDateToISO(date.apply_end_date, time.apply_end_date),
            } 
           const allCohortDetails = {...cohortDetails, tracks: trackIDs}
           addCohort.mutate(allCohortDetails)
        }
       
    }

    return (
        <div className="flex flex-col gap-8">
            <div className="flex flex-row justify-between items-center font-bold text-lg ">
            <h1 className="text-2xl font-semibold"> Add Cohort Details </h1>
            <span onClick={() => handleClose() }
                className="bg-black text-white rounded-full h-[40px] w-[40px] flex items-center justify-center hover:opacity-80 cursor-pointer">
                X</span>
            </div>
            <form className="flex flex-col gap-8" onSubmit={handleSubmit}>
                <div className="flex flex-col gap-4">
                    <label htmlFor="name" className="font-semibold">Cohort Name</label>
                    <input type="text" name="name" id="name"  className="p-4 border-[1px] border-black rounded-md"
                    onChange={(e) => setCohortName(e.target.value)}
                    />
                </div>
                <div className="flex flex-col gap-4">
                    <label htmlFor="start_date" className="font-semibold">Cohort Start Date & Time</label>
                    <div className="flex gap-5"> 
                        <input type="date" name="start_date" id="start_date" className=" flex-1 p-4 border-[1px] border-black rounded-md" 
                        onChange={handleChange}
                        />
                        <input type="time" name="start_date" id="start_date" className=" flex-1 p-4 border-[1px] border-black rounded-md"
                        onChange={handleTimeChange}
                        />
                    </div>
                    
                </div>
                <div className="flex flex-col gap-4">
                    <label htmlFor="end_date" className="font-semibold">Cohort End Date & Time</label>
                    <div className="flex gap-5">
                        <input type="date" name="end_date" id="end_date" className=" flex-1 p-4 border-[1px] border-black rounded-md"
                     onChange={handleChange}
                    />
                     <input type="time" name="end_date" id="end_date" className=" flex-1 p-4 border-[1px] border-black rounded-md"
                        onChange={handleTimeChange}
                        />
                    </div>
                   
                </div>
                <div className="flex flex-col gap-4 ">
                    <label htmlFor="apply_start_date" className="font-semibold">Application Start Date & Time</label>
                    <div className="flex gap-5">
                        
                        <input type="date" name="apply_start_date" id="apply_start_date" className=" flex-1 p-4 border-[1px] border-black rounded-md" 
                     onChange={handleChange}
                    />  
                    <input type="time" name="apply_start_date" id="apply_start_date" className=" flex-1 p-4 border-[1px] border-black rounded-md"
                        onChange={handleTimeChange}
                        />
                    </div>
                   
                </div>
                <div className="flex flex-col gap-4">
                    <label htmlFor="apply_start_date" className="font-semibold">Application End Date & Time</label>
                    <div className="flex gap-5">
                        <input type="date" name="apply_end_date" id="apply_end_date" className=" flex-1 p-4 border-[1px] border-black rounded-md" 
                     onChange={handleChange}
                    />
                    <input type="time" name="apply_end_date" id="apply_end_date"  className=" flex-1 p-4 border-[1px] border-black rounded-md"
                        onChange={handleTimeChange}
                        />
                    </div>
                   
                </div>
                <div className="flex flex-col gap-4">
                    <label className="font-semibold">Tracks</label>
                    {
                    allTrackIDs.map((track, index) => (
                        <div key={index} className="flex gap-4"
                        >
                            <input type="checkbox" name="track_id" id="track_id" value={track.id} className="accent-black" 
                            onChange={(e) => {
                                e.target.checked ? setTrackIDs([...trackIDs, track.id]) : setTrackIDs(trackIDs.filter((id) => id !== track.id));
                            }}
                            />
                            <label>{track.name}</label>
                        </div>
                        
                    ))
                }
                </div>
                {
                  addCohort.isSuccess ? 
                  <div className="flex-1 flex flex-col items-center space-y-4">
                     <span className="flex-1 text-center w-full bg-green-500 p-3 rounded-md font-semibold text-base text-white">
                    Cohort Added Sucessfully
                    </span>
                    <span onClick={() => handleClose()} className="text-center w-max bg-gray-700 p-2 pl-6 pr-6 rounded-md hover:opacity-80 font-semibold text-base text-white">
                     Close
                     </span>
                  </div>
                 : addCohort.isError ?
                <span className="flex-1 text-center bg-red-500 p-3 rounded-md font-semibold text-base text-white"
                onClick={()=> addCohort.reset()}
                >
                    Error Adding Cohort, Click to retry
                </span> : addCohort.isLoading ?
                    <div className="flex items-center justify-center">
                            <Loader css1={"h-[20px] w-[20px]"}/>
                    </div>
                : <button className="bg-black text-white p-4 rounded-md hover:opacity-90">Add Cohort</button>
                }
                
            </form>
        </div>
    )
}
