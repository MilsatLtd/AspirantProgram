/* eslint-disable react/prop-types */
import { useState } from "react"
import { useParams } from "react-router-dom";
import Enums from "./constant/enum";
import utils from "./constant/common";
import { useQuery } from "@tanstack/react-query";
import fetAllApplications from "./api/fetchAllApplications";
import Modal from "./Modal";
import reviewApplication from "./api/reviewApplication";
import { useMutation } from "@tanstack/react-query";

function StudentColumn ( { student, passApplicantId }) {
    if (!student) {
        return <td></td>
    }
    const student_status = utils.getEnumKeyByValue(Enums.APPLICATION_STATUS, student.status)

    const passApplicant = (student) => {
        passApplicantId(student)
    }

    return (
            <td>
                <div className="grid grid-cols-4 items-center gap-16">
                    <h3 className="col-span-2">
                        {student.user.first_name + " " + student.user.last_name}
                    </h3>
                    <div className="">
                    <span className={`m-2 text-xs font-medium text-black rounded-2xl p-3 ${student.status === Enums.APPLICATION_STATUS.ACCEPTED ? 'bg-green-200' : student.status === Enums.APPLICATION_STATUS.REJECTED ? 'bg-red-200' : 'bg-blue-200'}`}>{student_status}</span>
                    </div>
                        <a onClick={() => passApplicant(student)}
                            className="active:bg-black active:text-white rounded-xl pl-3 pr-3 px-2 py-2 text-sm bg-white
                            text-black border-solid border-2 border-black hover: transition-colors duration-300
                            font-semibold shadow-2xl"
                        >
                            View
                        </a>
                </div>
            </td>
    )
}

function MentorColumn ( { mentor, passApplicantId }) {
    if (!mentor) {
        return <td></td>
    }
    const mentor_status = utils.getEnumKeyByValue(Enums.APPLICATION_STATUS, mentor.status)

    const passApplicant = (mentor) => {
        passApplicantId(mentor)
    }


    return (
            <td>
                <div className="grid grid-cols-4 items-center gap-16">
                    <h3 className="col-span-2">
                        {mentor.user.first_name + " " + mentor.user.last_name}
                    </h3>
                    <div className="">

                    <span className={`m-2 text-xs font-medium text-black rounded-2xl p-3 ${mentor.status === Enums.APPLICATION_STATUS.ACCEPTED ? 'bg-green-200' : mentor.status === Enums.APPLICATION_STATUS.REJECTED ? 'bg-red-200' : 'bg-blue-200'}`}>{mentor_status}</span>
                    </div>
                        <a onClick={()=>passApplicant(mentor)}

                            className="active:bg-black active:text-white rounded-xl pl-3 pr-3 px-2 py-2 text-sm bg-white
                            text-black border-solid border-2 border-black hover: transition-colors duration-300
                            font-semibold shadow-2xl"
                        >
                            View
                        </a>
                </div>
            </td>



    )
}


function Applications() {
    const [details, setDetails] = useState({});
    const [isShowDetails, setIsShowDetails] = useState(false);

    const { cohort_id } = useParams();
    const results = useQuery(["applications"], fetAllApplications);

    const applications = results?.data ?? [];

    const cohort_applications = applications.filter(application => application.cohort === cohort_id)
    const interns = cohort_applications.filter(application => application.role === Enums.ROLE.STUDENT);
    const mentors = cohort_applications.filter(application => application.role === Enums.ROLE.MENTOR);

    const pairs = [];
    for (let i = 0; i < Math.max(interns.length, mentors.length); i++) {
        pairs.push([interns[i], mentors[i]]);
    }
    return (
        <>
        <div className="grid grid-cols-3 m-10">

        <table className="col-start-1 col-span-3 w-full border-separate border-spacing-x-2 border-spacing-y-1">
            <thead className="bg-gray-300">
                <tr className="">
                    <th className="text-xl font-bold">STUDENTS</th>
                    <th className="text-xl font-bold">MENTORS</th>
                </tr>
            </thead>
            <tbody className="bg-gray-100">
                {
                    pairs.map((pair, index) => {
                        return (
                           <tr key={index}> 
                                <StudentColumn passApplicantId={(id) => {
                                    setDetails(id);
                                    setIsShowDetails(true);
                                    
                                }} student={pair[0]} />
                                <MentorColumn passApplicantId={(id) => {
                                    setDetails(id);
                                    setIsShowDetails(true);
                                    }} mentor={pair[1]} />
                            </tr>
                        )
                    })
                }                
            </tbody>
        </table>
        </div>
        {
            isShowDetails ? (
            <Modal>
                <ApplicationDetails details={details} close={() => {
                    setIsShowDetails(false)
                    results.refetch()
                } } />
            </Modal>) : null
        }
        </>
    )
}

function ApplicationRow ( {label, detail} ) {
    const [trackName, setTrackName] = useState("")
   


    return (
        <div className=" flex flex-col">
            <label htmlFor="">{label}:</label>
            {
                label === "file" ? (
                    <a href={detail} className="min-h-[50px] px-3 flex items-center  text-blue-500 cursor:"
                    target="_blank"   
                    >{detail}</a>
                ) : label === "submission_date" || label === "review_date" ? (
                    <p className="border-2 border-black min-h-[50px] px-3 flex items-center ">{utils.formatDate(detail)}</p>
                ):
                    label === "role" ? (
                        <p className="border-2 border-black min-h-[50px] px-3 flex items-center normal-case">{utils.getEnumKeyByValue(Enums.ROLE, detail)}</p>
                    ) : label === "status" ? (
                        <p className="border-2 border-black min-h-[50px] px-3 flex items-center normal-case ">{utils.getEnumKeyByValue(Enums.APPLICATION_STATUS, detail)}</p>
                    ):
                    label === "education" ? (
                        <p className="border-2 border-black min-h-[50px] px-3 flex items-center normal-case">{utils.getEnumKeyByValue(Enums.EDUCATION, detail)}</p>
                    ):
                    label === "gender" ? (
                        <p className="border-2 border-black min-h-[50px] px-3 flex items-center normal-case">{utils.getEnumKeyByValue(Enums.GENDER, detail)}</p>
                    ):
                    label === "track" ? (
                        <p className="border-2 border-black min-h-[50px] px-3 flex items-center normal-case">{detail?.name}</p>
                    ):
                (
                    <p className="border-2 border-black min-h-[50px] px-3 flex items-center normal-case ">{detail}</p>
                )
            }
        </div>
    )

}

function ApplicationDetails ( {details, close} ) { 
    const user = details.user
    const [status, setStatus] = useState(details.status)

    const review = useMutation(() => reviewApplication(details.applicant_id, status))

    const handleClose = () => {
        close()
    }

    return (
        <>
        <div className="m-7">
        <div className="flex flex-row justify-between items-center font-bold text-lg m-5">
            <h1 className="text-2xl font-semibold"> Application Details </h1>
            <span onClick={() => handleClose() }
                className="bg-black text-white rounded-full h-[40px] w-[40px] flex items-center justify-center hover:opacity-80 cursor-pointer">
                X</span>
        </div>
        <div className="flex flex-col gap-5">
        {
            Object.keys(details.user).filter(key => key !=='user')
            .map((key, index) => {
                return (    
                    <ApplicationRow key={index} label={key} detail={details.user[key]} />
                )
            })
        }
        {

        Object.keys(details).filter(key => key !=='user')
        .map((key, index) => {
            return (
                <ApplicationRow key={index} label={key} detail={details[key]} />
            )
        })
        }
        <div className="m-10">
        {
            status === 0 ? 
        <div className="w-full flex gap-16">
            <button onClick={() => {
                setStatus(2)
                review.mutate()
                }} className="flex-1 bg-red-500 p-2 rounded-md hover:opacity-80 font-semibold text-base text-white">
                Decline
            </button>
            <button onClick={
                () => {
                    setStatus(1)
                    review.mutate()
                }
                } 
                className="flex-1 bg-blue-500 p-2 rounded-md hover:opacity-80 font-semibold text-base text-white">
                Accept
            </button>
        </div> : 
        <div className="w-full flex gap-16">
            {
            status === 1 ? <span className="flex-1 text-center bg-green-500 p-3 rounded-md font-semibold text-base text-white">
                Application Passed
            </span> : status === 2 ? <span className="flex-1 text-center bg-red-500 p-2 rounded-md font-semibold text-base text-white ">
                Application Declined
            </span> : null
            }
        </div>
        } 
        <div className="flex justify-center m-7">

        <span onClick={() => handleClose()} className="text-center bg-gray-700 p-2 pl-6 pr-6 rounded-md hover:opacity-80 font-semibold text-base text-white">
            Close
        </span>
        </div>
        </div>
        </div>
        </div>
        </>
    )
}
// create a modal to show application details

export default Applications