import { useParams } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import Navbar from "./Navbar";
import Loader from "./Loader";
import fetchTrackById from "./api/fetchTrackById";



const TrackDetails = () => {
    const { track_id } = useParams();
    const results = useQuery( ['itrack'], () => fetchTrackById(track_id), { staleTime: 1000 * 60 * 5 })
    const track = results.data?? {
        name: "",
        description: "",
        courses: []
    };
    console.log(track)

  return (
        <>
        <Navbar  showLinks={true}/>
        <div className="flex">
        <h1 className="text-4xl font-semibold m-7">Track Details</h1>
        {results.isLoading ? <Loader css1={"flex justify-center items-center"} css2="w-[30px] h-[30px]" /> : null}
        </div>
        <form action="">
            <div className="pl-2">
                <div className="grid grid-cols-1 gap-20">
                    <div className="flex flex-col gap-5 ml-5 w-[600px]">
                        <label className="font-bold text-xl" htmlFor="cohort_name">Track Name</label> 
                        <input className="border-2 border-black rounded-xl p-2 "
                            type="text" name="cohort_name" id="cohort_name" defaultValue={track.name}/>
    
                        <label className="font-bold text-xl" htmlFor="cohort_status">Track Description</label>
                        <input className="border-2 border-black rounded-xl p-2 "
                            type="text" name="cohort_status" id="cohort_status" defaultValue={track.description}/>
    
                    </div>
                    <div className="flex flex-col gap-8">
                            <h1 className="text-3xl font-semibold ">Courses:</h1>
                            <div className="grid grid-col-2 ml-10 w-2/3 ">
                                <div className="col-span-1 flex flex-col gap-8">
                                    {track.courses.map((course, index) => {
                                        return (
                                           <CoursesDetails key={index} courseNo={index+1} course={course} />
                                        )
                                    })}
                                </div>
                            </div>  
                        </div>
                </div>
            </div>
        </form>
        
        </>
  )
}

export default TrackDetails


const CoursesDetails = ({ course, courseNo }) => {
    return(
        <div className="flex flex-col gap-4">
         <h1 className="text-2xl font-bold ">Course {courseNo}: </h1>
        <div className="flex flex-col pl-24 gap-8">
            <div className="flex flex-col gap-2">
                    <label className="font-bold text-xl" htmlFor="cohort_name">Course Name</label> 
                    <input className="border-2 border-black rounded-xl p-2 "type="text" name="cohort_name" id="cohort_name" defaultValue={course.name}>
                    </input>
            </div>
                <div className="flex flex-col gap-2">
                    <label className="font-bold text-xl" htmlFor="cohort_name">Course Description</label> 
                    <textarea className="border-2 border-black rounded-xl p-2 "type="text" name="cohort_name" id="cohort_name" defaultValue={course.description}>
                    </textarea>
                </div>
                <div className="flex flex-col gap-2">
                    <label className="font-bold text-xl" htmlFor="cohort_name">Course Requirements</label> 
                    <textarea className="border-2 border-black rounded-xl p-2 "type="text" name="cohort_name" id="cohort_name" defaultValue={course.requirements}>
                    </textarea>
                </div>
                <div className="flex flex-col gap-2">
                    <label className="font-bold text-xl" htmlFor="cohort_name">Course access link</label> 
                    <input className="border-2 border-black rounded-xl p-2 "type="text" name="cohort_name" id="cohort_name" defaultValue={course.access_link}/>
                </div>

        </div>
        </div>
    )
}