import { useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import { useQuery, useMutation } from "@tanstack/react-query";
import updateTrackById from "./api/updateTrackById";
import utils from "./constant/common";
import Navbar from "./Navbar";
import Loader from "./Loader";
import fetchTrackById from "./api/fetchTrackById";
import Modal from "./Modal";
 


const TrackDetails = () => {
    const [isUpdateTrack, setIsUpdateTrack] = useState(false);
    const { track_id } = useParams();
    const results = useQuery( ['itrack'], () => fetchTrackById(track_id), { staleTime: 1000 * 60 * 5 })
    const track = results.data?? {
        name: "",
        description: "",
        courses: []
    };


  return (
        <>
        <Navbar  showLinks={true}/>
        <div className="flex items-center gap-10 m-7">
        <h1 className="text-4xl font-semibold ">Track Details</h1>
        {results.isLoading ? <Loader css1={"flex justify-center items-center"} css2="w-[30px] h-[30px]" /> : null}

        <button 
                className="active:bg-black active:text-white p-2 pl-3 pr-3 rounded-xl text-sm bg-white 
                text-black border-solid border-4 border-black hover: transition-colors duration-300
                font-semibold shadow-2xl h-max"
                    onClick={() => setIsUpdateTrack(true)}
                >
                Update Track
                </button>
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
                            <div className="flex flex-row justify-between gap-4 mx-10">
                            <h1 className="text-3xl font-semibold ">Courses:</h1>
                            </div>
                            <div className="grid grid-col-2 ml-10 w-2/3 ">
                                <div className="col-span-1 flex flex-col gap-8">
                                    {
                                        track.courses.length > 0 ? track.courses.map((course, index) => {
                                            return <CoursesDetails course={course} courseNo={index+1} key={course.id}/>
                                        }) : (
                                        <div>
                                            <h1 className="text-2xl font-semibold">No courses</h1>
                                        </div>
                                        )
                                    }
                                </div>
                            </div>  
                        </div>
                </div>
            </div>
        </form>
        {
            isUpdateTrack ?
            <Modal>
            <UpdateTrack closeEdit={()=>{
               setIsUpdateTrack(false);
               results.refetch(); 
            }}
            trachId={track_id}
            />
        </Modal> : null
        }
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



function UpdateTrack ({closeEdit, trackId}) {
    const [trackDetails, setTrackDetails] = useState({})
    const results = useQuery( ['itrack'], () => fetchTrackById(trackId), { staleTime: 1000 * 60 * 5 })
    const track = results.data?? {
        name: "",
        description: "",
        courses: []
    };
    // const [trackIDs, setTrackIDs] = useState([])
    const [courses, setCourses] = useState([])
    const [courseDetails, setCourseDetails] = useState([])
    const handleClose = () => {
        closeEdit();
    }
    
    const handleChange = (e) => {
        const { name, value } = e.target;
        setTrackDetails((prevState) => ({
            ...prevState,
            [name]: value,
        }));
        console.log(trackDetails)
    }

    useEffect(() => {
        setTrackDetails(track)
        setCourses(track.courses)
        setCourseDetails(track.courses)
    }, [trackDetails])

    const handleSubmit = (event) => {
        event.preventDefault();
        console.log(trackDetails)
        const formattedCourseDetails = utils.formatCourseDetails(courseDetails)
        const allTrackDetails = {name: trackDetails.name,
            description: trackDetails.description,  
            courses: formattedCourseDetails}
        console.log(allTrackDetails)
        updateTrackById(trackDetails.track_id, allTrackDetails)
        handleClose();
    }


    const handleAddCourses =(courseInfo) => {
        const updatedCourses = courseDetails
        setCourseDetails([...updatedCourses, courseInfo])
    }

    const handleUpdateCourse = (id, newCourseDetails) => {
        const updatedCourses = courseDetails.map(obj => {
            if (obj.id === id) {
              return { ...obj, ...newCourseDetails };
            } else {
              return obj;
            }
          });
        setCourseDetails(updatedCourses)
    }

    const handleRemoveCourse = (id) => { 
    const newCourselist = courses.filter((course) => course.id !== id)
    setCourses(newCourselist)  
    const newCourseDetails = courseDetails.filter((course) => course.id !== id)
    setCourseDetails(newCourseDetails)
}

    return (
        <div className="flex flex-col gap-8">
            <div className="flex flex-row justify-between items-center font-bold text-lg ">
            <h1 className="text-2xl font-semibold"> Update Track Details </h1>
            <span onClick={() => handleClose() }
                className="bg-black text-white rounded-full h-[40px] w-[40px] flex items-center justify-center hover:opacity-80 cursor-pointer">
                X</span>
            </div>
            <form className="flex flex-col gap-8" onSubmit={handleSubmit}>
                <div className="flex flex-col gap-4">
                    <label htmlFor="name" className="font-semibold">Track Name</label>
                    <input type="text" name="name" id="name"  className="p-4 border-[1px] border-black rounded-md"
                    defaultValue={track.name}
                    onChange={handleChange}
                    />
                </div>
                <div className="flex flex-col gap-4">
                    <label htmlFor="start_date" className="font-semibold">Description</label>
                    <input type="text" name="description" id="description" className="p-4 border-[1px] border-black rounded-md" 
                    defaultValue={track.description}
                     onChange={handleChange}
                    />
                </div>
                <div className="flex flex-col gap-4">
                    <h3 className="font-semibold text-lg">Courses: </h3>
                    <div className="flex flex-col gap-8">
                    {
                        courses.map((course, index) => {
                            return ( 
                                <CourseEdit key={index} 
                                addCourse={handleAddCourses} 
                                updateCourse={handleUpdateCourse}
                                courseNo={course.id} 
                                removeCourse={handleRemoveCourse} /> 
                            )
                        })
                    }
                    </div>
                    <a className="bg-black text-white p-4 w-max rounded-md hover:opacity-90 cursor-pointer"
                     onClick={() =>setCourses(courses.concat({id:1 + courses.length})) }
                    >
                        + Create New Course
                    </a>
                </div>
                <button className="bg-black text-white p-4 rounded-md hover:opacity-90">Update Track</button>
            </form> 
        </div>
    )
}


function CourseEdit ({addCourse, courseNo, removeCourse, updateCourse}) {
    const [courseDetails, setCourseDetails] = useState({
        name: "",
        description: "",
        requirements: "",
        access_link: ""
    })
    const [courseError, setCourseError] = useState({
        name: "",
        description: "",
        requirements: "",
        access_link: ""
    })
    const [showUpdate, setShowUpdate] = useState(false)
    const [activateError, setActivateError] = useState(false)


    const handleChange = (e) => {
        const { name, value } = e.target;
        setCourseDetails((prevState) => ({
            ...prevState,
            [name]: value,
        }));
        courseError[name] = ""
        setCourseError(courseError)
    }

    const handleSubmit = () => {
        const allCourseDetails = {...courseDetails, id: courseNo}
        const result = CheckValidation(allCourseDetails)
        setCourseError(result)
        const allEmpty = Object.values(result).every(value => value === '');
        if(allEmpty) {
            addCourse(allCourseDetails) 
            setShowUpdate(true)
        }else{
            setActivateError(true)
        }
}

    const CheckValidation = (details) => {
        if(!details.name){
            courseError.name = "name is required"
        }
        if(!details.description){
            courseError.description=  "Course description is required"
         }
         if(details.description.length > 120){
            courseError.description = "Course description is more than 120 characters"
         }
         if(!details.requirements){
            courseError.requirements = "Requirements are required"
         }
         if(!details.access_link){
            courseError.access_link = "Access link is required"
         }
        return courseError
    }

    const handleUpdate = () => {
        updateCourse(courseNo, courseDetails)
    }

    const handleRemoveCourse = () => {
        removeCourse(courseNo)
    }


    return(
        <div className="ml-20 flex flex-col gap-6" > 
        <div className="flex items-center justify-between">
        <h3 className="font-semibold text-lg">Course: {courseNo}</h3>
        <a className=" bg-red-600 text-white p-2 rounded-md hover:opacity-90 cursor-pointer"
            onClick={handleRemoveCourse}
            >Remove Course</a>
        </div>
            
            <div className="flex flex-col gap-4">
                <label htmlFor="name" className="font-semibold">Name</label>
                <div className="w-full">
                <input type="text" name="name" id="name"  placeholder="e.g Geospatial Front-end"  className={`w-full p-4 border-[1px] ${courseError.name ? "border-red-400": "border-black"}  rounded-md`}
                onChange={handleChange}
                />
                <span className="min-h-4 text-red-500">
                {courseError.name && activateError && courseError.name}
                </span>
                </div>
                
            </div>
            <div className="flex flex-col gap-4">
                <label htmlFor="description" className="font-semibold">Description</label>
                <div className="w-full">
                <textarea type="text" name="description" id="description"  className={`p-4 w-full h-[80px] border-[1px] ${courseError.description ? "border-red-400": "border-black"} border-black rounded-md`}
                onChange={handleChange}
                >
                </textarea>
                <span className="min-h-4 text-red-500">
                {courseError.description && activateError && courseError.description  }
                </span>
                </div>
                
            </div>
            <div className="flex flex-col gap-4">
                <label htmlFor="requirements" className="font-semibold">Requirements</label>
                <div className="w-full">
                <textarea type="text" name="requirements" id="requirements"  className={`w-full h-[80px] p-4 border-[1px] ${courseError.requirements ? "border-red-400": "border-black"} rounded-md`}
                onChange={handleChange}
                >
                </textarea>
                <span className="min-h-4 text-red-500">
                {courseError.requirements && activateError  && courseError.requirements}
                </span>
                </div>
                
            </div>
            <div className="flex flex-col gap-4">
                <label htmlFor="access_link" className="font-semibold">Access Link</label>
                <div className="w-full">
                    <input type="text" name="access_link" id="access_link" defaultValue={"https://"} placeholder="e.g https://www.course.com"  className={`w-full p-4 border-[1px] ${courseError.access_link ? "border-red-400": "border-black"} rounded-md`}
                    onChange={handleChange}
                    />
                    <span className="min-h-4 text-red-500">
                    { courseError.access_link && activateError && courseError.access_link}
                    </span>
                </div>
                
            </div>
            <div className="flex justify-end">
            {
                showUpdate ?
                <a className=" bg-yellow-500 text-black font-semibold p-4 rounded-md hover:opacity-90 cursor-pointer"
                onClick={handleUpdate}
                >Update Course</a>:
                <a className="bg-black text-white p-4 rounded-md hover:opacity-90 cursor-pointer"
                onClick={handleSubmit}
                >Add Course</a>
            }
            </div>
           
        </div>
    )
}