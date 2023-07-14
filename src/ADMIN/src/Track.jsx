/* eslint-disable react/prop-types */
import Navbar from "./Navbar";
import { useQuery, useMutation } from "@tanstack/react-query";
import fetAllTracks from "./api/fetchAllTracks";
import addNewTrack from "./api/addNewTrack";
import { Link } from "react-router-dom";
import { useEffect, useState } from "react";
import utils from "./constant/common";
import Modal from "./Modal";


function Loader() {
    return (
      <div className="flex justify-center items-center">
        <div className="animate-spin rounded-full h-7 w-7 border-t-4 border-b-4 border-blue-500 text-sm ml-10 text-purple-900">map</div>
      </div>
    );
  }
  

// eslint-disable-next-line react/prop-types
function TrackRow( { Track, details } ) {
    const [ncourses, setncourses] = useState(0)
    const [ name , setName ] = useState("")

    useEffect(() => {
        if (Track){
            if (Track.courses){
                setncourses(Track.courses.length)
                setName(Track.name)
            }
        }
    }, [Track])

    if (details === "TableHeader") {
        return (
            <tr className="flex items-center w-full">
                <th className="flex-1 flex items-start">Track Name</th>
                <th className="flex-1 flex items-start">Number of courses</th>
                <th className="flex-1 flex items-start">Details</th>
            </tr>
        );
    }

    return (
        <tr className="flex justify-between w-full">
            <td className="flex-1 flex font-semibold">{name}</td>
            <td className="flex-1 flex">{ncourses}</td>
            <td className="flex-1 flex">
            <Link to={`/Tracks/${Track.track_id}`} state={Track}>
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


function TrackTable() {
    const [isNewTrackEdit, setIsNewTrackEdit] = useState(false);
    const results = useQuery(["Tracks"], fetAllTracks);
    const Tracks = results?.data ?? [];

    return (
        <div>
        <div>
            <Navbar showLinks={true}/>
            <div className="w-[90%] mx-auto">
            <div className="w-full">
            <div className="header"> 
                <div className="flex items-center justify-between">
                    <div className="flex-1 flex ">
                    <h1 className="flex justify-center my-20 text-5xl leading-5"> Tracks </h1>
                    {
                    results.isLoading ? <Loader /> : null
                    }
                    </div>
                    
                   
                    <button
                     className=" bg-black text-white font-medium rounded-md flex items-center p-4 hover:opacity-80"
                     onClick={()=>setIsNewTrackEdit(true)}
                     >
                        + Add Tracks
                    </button>
                </div>
                
                
                </div>
                    <div className="">
                        <table className="grid grid-rows-1 w-full">
                            <thead className="bg-gray-300 text-l">
                                <TrackRow details="TableHeader"/>
                            </thead>
                            <tbody className="bg-gray-50 text-sm">
                                {Tracks.map((Track, index) => (
                                    <TrackRow
                                        key={index}
                                        Track={Track}
                                    />
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        {
            isNewTrackEdit ?
            <Modal>
            <NewTrack closeEdit={()=>{
               setIsNewTrackEdit(false);
               results.refetch(); 
            }}/>
        </Modal> : null
        }
       
        </div>
    );
}
export default TrackTable;

function NewTrack ({closeEdit}) {
    const [trackDetails, setTrackDetails] = useState({})
    // const [trackIDs, setTrackIDs] = useState([])
    const [courses, setCourses] = useState([])
    const [courseDetails, setCourseDetails] = useState([])
    const handleClose = () => {
        closeEdit();
    }
    // const results = useQuery(["Tracks"], fetAllTracks);
    const addTrack = useMutation((newTrack) => addNewTrack(newTrack))
    // const tracks = results?.data ?? [];
    // const allTrackIDs = tracks.map((track)=>( { id: track.track_id, name: track.name}))

    const handleChange = (e) => {
        const { name, value } = e.target;
        setTrackDetails((prevState) => ({
            ...prevState,
            [name]: value,
        }));
        console.log(trackDetails)
    }

    const handleSubmit = (event) => {
        event.preventDefault();
        console.log(trackDetails)
        const formattedCourseDetails = utils.formatCourseDetails(courseDetails)
        const allTrackDetails = {...trackDetails, courses: formattedCourseDetails}
        console.log(allTrackDetails)
        addTrack.mutate(allTrackDetails)
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
            <h1 className="text-2xl font-semibold"> Add Track Details </h1>
            <span onClick={() => handleClose() }
                className="bg-black text-white rounded-full h-[40px] w-[40px] flex items-center justify-center hover:opacity-80 cursor-pointer">
                X</span>
            </div>
            <form className="flex flex-col gap-8" onSubmit={handleSubmit}>
                <div className="flex flex-col gap-4">
                    <label htmlFor="name" className="font-semibold">Track Name</label>
                    <input type="text" name="name" id="name"  className="p-4 border-[1px] border-black rounded-md"
                    onChange={handleChange}
                    />
                </div>
                <div className="flex flex-col gap-4">
                    <label htmlFor="start_date" className="font-semibold">Description</label>
                    <input type="text" name="description" id="description" className="p-4 border-[1px] border-black rounded-md" 
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
                <button className="bg-black text-white p-4 rounded-md hover:opacity-90">Add Track</button>
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
        console.log(result)
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