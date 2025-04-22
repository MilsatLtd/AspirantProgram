import { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import Head from "next/head";
import axios from "axios";
import { useRouter } from "next/router";
import Logo from "../../../Assets/logo.svg";

const MenteeDetail = () => {
  const router = useRouter();
  const { id } = router.query; // This is the mentee's user_id from the URL
  
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [menteeData, setMenteeData] = useState({
    full_name: "",
    email: "",
    bio: "",
    profile_picture: "",
    progress: "0%",
    last_active: null,
    tasks: [],
    courses: [],
    assessments: []
  });
  
  const [mentorData, setMentorData] = useState({
    name: "",
    email: "",
    track: "",
    cohort: "",
    profilePicture: ""
  });
  
  const [selectedTab, setSelectedTab] = useState("overview");
  const [feedbackMessage, setFeedbackMessage] = useState("");
  const [taskNote, setTaskNote] = useState("");
  
  useEffect(() => {
    const token = localStorage.getItem("token");
    const role = localStorage.getItem("userRole");
    
    if (!token) {
      router.push("/login");
      return;
    }
    
    // Ensure this is a mentor account
    if (role !== "2") {
      router.push("/dashboard");
      return;
    }
    
    if (id) {
      fetchMenteeData();
      fetchMentorData();
    }
  }, [id]);
  
  const fetchMenteeData = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem("token");
      const userId = localStorage.getItem("userId"); // Get the current mentor's ID
      
      if (!token || !userId) {
        throw new Error("Authentication required");
      }
      
      // Get mentor's track
      const recentTrackResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/recent/${userId}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      if (recentTrackResponse.data && recentTrackResponse.data.track) {
        const trackId = recentTrackResponse.data.track;
        
        // Get mentor data including mentees
        const mentorResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}/${trackId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        // Find the specific mentee from the list
        const menteeInfo = mentorResponse.data.mentees.find(mentee => mentee.user_id === id);
        
        if (!menteeInfo) {
          throw new Error("Mentee not found");
        }
        
        setMenteeData({
          full_name: menteeInfo.full_name || "Mentee",
          email: menteeInfo.email || "",
          bio: menteeInfo.bio || "No bio available.",
          profile_picture: menteeInfo.profile_picture || "",
          progress: "0%", 
          last_active: null,
          tasks: generateMockTasks(),
          courses: generateMockCourses(),
          assessments: generateMockAssessments()
        });
      } else {
        throw new Error("Mentor track information not found");
      }
    } catch (error) {
      console.error("Error fetching mentee data:", error);
      setError("Failed to load mentee details. Please try again later.");
    } finally {
      setLoading(false);
    }
  };
  
  const fetchMentorData = async () => {
    try {
      const token = localStorage.getItem("token");
      const userId = localStorage.getItem("userId");
      
      if (!token || !userId) {
        throw new Error("Authentication required");
      }
      
      // Get mentor track info
      const recentTrackResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/recent/${userId}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      let trackId;
      if (recentTrackResponse.data && recentTrackResponse.data.track) {
        trackId = recentTrackResponse.data.track;
        
        // Get mentor profile with track
        const mentorResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}/${trackId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        setMentorData({
          name: mentorResponse.data.full_name || "Mentor",
          email: mentorResponse.data.email || "",
          track: mentorResponse.data.track?.name || "Unassigned",
          cohort: mentorResponse.data.cohort?.name || "Current Cohort",
          profilePicture: mentorResponse.data.profile_picture || ""
        });
      } else {
        // Fallback to basic mentor info
        const basicMentorResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        setMentorData({
          name: basicMentorResponse.data.full_name || "Mentor",
          email: basicMentorResponse.data.email || "",
          track: basicMentorResponse.data.track?.name || "Unassigned",
          cohort: basicMentorResponse.data.cohort?.name || "Current Cohort",
          profilePicture: basicMentorResponse.data.profile_picture || ""
        });
      }
    } catch (error) {
      console.error("Error fetching mentor data:", error);
    }
  };
  
  const generateMockTasks = () => {
    return [
      {
        id: "task-1",
        title: "Complete Module 1 Assessment",
        description: "Submit the assessment for Module 1 - Introduction",
        status: "completed",
        due_date: "2025-04-10",
        completed_date: "2025-04-09"
      },
      {
        id: "task-2",
        title: "Review Field Mapping Techniques",
        description: "Review and take notes on GIS mapping techniques covered in Lecture 3",
        status: "in_progress",
        due_date: "2025-04-20",
        completed_date: null
      },
      {
        id: "task-3",
        title: "Submit Project Proposal",
        description: "Submit your project proposal for the field mapping assignment",
        status: "pending",
        due_date: "2025-04-30",
        completed_date: null
      }
    ];
  };
  
  const generateMockCourses = () => {
    return [
      {
        id: "course-1",
        name: "Introduction to Data Collection",
        progress: "100%",
        completed_modules: 5,
        total_modules: 5
      },
      {
        id: "course-2",
        name: "Field Mapping Fundamentals",
        progress: "60%",
        completed_modules: 3,
        total_modules: 5
      },
      {
        id: "course-3",
        name: "Data Analysis Techniques",
        progress: "20%",
        completed_modules: 1,
        total_modules: 5
      }
    ];
  };
  
  const generateMockAssessments = () => {
    return [
      {
        id: "assessment-1",
        title: "Module 1 Quiz",
        score: "90%",
        status: "completed",
        date: "2025-04-05"
      },
      {
        id: "assessment-2",
        title: "Field Mapping Exercise",
        score: "75%",
        status: "completed",
        date: "2025-04-12"
      },
      {
        id: "assessment-3",
        title: "Final Project",
        score: null,
        status: "pending",
        date: null
      }
    ];
  };
  
  const sendFeedback = async () => {
    if (!feedbackMessage.trim()) return;
    
    try {
      const token = localStorage.getItem("token");
      
      console.log("Sending feedback:", {
        mentee_id: id,
        message: feedbackMessage
      });
      
      // Mock API call response
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Clear the message after sending
      setFeedbackMessage("");
      
      // Show success notification (you could add a toast notification here)
      alert("Feedback sent successfully!");
    } catch (error) {
      console.error("Error sending feedback:", error);
      alert("Failed to send feedback. Please try again.");
    }
  };
  
  const addTaskNote = async (taskId) => {
    if (!taskNote.trim()) return;
    
    try {
      const token = localStorage.getItem("token");
      
      console.log("Adding task note:", {
        task_id: taskId,
        note: taskNote
      });
      
      // Mock API call response
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Clear the note after adding
      setTaskNote("");
      
      // Show success notification
      alert("Note added successfully!");
    } catch (error) {
      console.error("Error adding note:", error);
      alert("Failed to add note. Please try again.");
    }
  };
  
  const formatDate = (dateString) => {
    if (!dateString) return "N/A";
    
    const date = new Date(dateString);
    return date.toLocaleDateString("en-US", {
      year: "numeric",
      month: "short",
      day: "numeric"
    });
  };
  
  const getLastActiveTime = (dateString) => {
    if (!dateString) return "Not available";
    
    const date = new Date(dateString);
    const now = new Date();
    const diffTime = Math.abs(now - date);
    const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
    
    if (diffDays === 0) {
      return "Today";
    } else if (diffDays === 1) {
      return "Yesterday";
    } else if (diffDays < 7) {
      return `${diffDays} days ago`;
    } else {
      return formatDate(dateString);
    }
  };
  
  const getStatusColor = (status) => {
    switch (status) {
      case "completed":
        return "bg-green-100 text-green-800";
      case "in_progress":
        return "bg-blue-100 text-blue-800";
      case "pending":
        return "bg-yellow-100 text-yellow-800";
      default:
        return "bg-gray-100 text-gray-800";
    }
  };
  
  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-N50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-t-4 border-b-4 border-P300 mx-auto"></div>
          <p className="mt-16 font-medium text-N300">Loading mentee details...</p>
        </div>
      </div>
    );
  }
  
  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-N50">
        <div className="bg-N00 p-24 rounded-lg shadow-xl max-w-md w-full">
          <div className="text-center text-R300 mb-16">
            <svg xmlns="http://www.w3.org/2000/svg" className="h-32 w-32 mx-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <h3 className="text-xl font-bold text-N500 mb-8">Error</h3>
          <p className="text-N300 mb-16">{error}</p>
          <Link href="/mentor-dashboard">
            <button className="w-full bg-P300 text-N00 py-12 px-24 rounded-lg hover:bg-P200 transition duration-300 font-semibold">
              Back to Dashboard
            </button>
          </Link>
        </div>
      </div>
    );
  }
  
  return (
    <>
      <Head>
        <title>{menteeData.full_name} | Mentor Dashboard</title>
      </Head>
      
      <div className="min-h-screen bg-N50">
        {/* Navigation */}
        <header className="bg-N00 shadow-xl">
          <div className="container mx-auto px-16 lg:px-48">
            <div className="flex items-center justify-between py-16">
              <Link href="/mentor-dashboard">
                <div className="inline-block">
                  <Image src={Logo} alt="MAP-logo" className="h-auto w-auto" />
                </div>
              </Link>
              
              <div className="flex items-center space-x-16">
                <div className="text-right mr-16">
                  <p className="text-sm font-medium text-N300">{mentorData.name}</p>
                  <p className="text-xs text-N200">Mentor - {mentorData.track}</p>
                </div>
                <div className="bg-P300 text-N00 rounded-full w-40 h-40 flex items-center justify-center">
                  {mentorData.profilePicture ? (
                    <Image 
                      src={mentorData.profilePicture}
                      alt={mentorData.name}
                      width={40}
                      height={40}
                      className="rounded-full"
                    />
                  ) : (
                    <span className="font-semibold">{mentorData.name ? mentorData.name.charAt(0) : "M"}</span>
                  )}
                </div>
              </div>
            </div>
          </div>
        </header>
        
        {/* Main Content */}
        <main className="container mx-auto px-16 lg:px-48 py-32">
          {/* Back button */}
          <div className="mb-16">
            <button 
              onClick={() => router.back()}
              className="flex items-center text-P300 hover:text-P200 font-medium"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-16 w-16 mr-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
              </svg>
              Back to Dashboard
            </button>
          </div>
          
          {/* Mentee Header */}
          <div className="bg-P300 text-N00 rounded-lg p-24 mb-32 shadow-card">
            <div className="flex flex-col md:flex-row items-start gap-24">
              <div className="w-80 h-80 rounded-full overflow-hidden bg-N00 flex-shrink-0">
                {menteeData.profile_picture ? (
                  <Image 
                    // src={menteeData.profile_picture}
                    alt={menteeData.full_name}
                    width={80}
                    height={80}
                    className="w-full h-full object-cover"
                  />
                ) : (
                  <div className="w-full h-full flex items-center justify-center bg-P100 text-P300">
                    <span className="font-semibold text-xl">{menteeData.full_name.charAt(0)}</span>
                  </div>
                )}
              </div>
              
              <div className="flex-1">
                <h1 className="text-2xl font-bold mb-8">{menteeData.full_name}</h1>
                <p className="text-sm mb-16 opacity-90">{menteeData.email}</p>
                
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-16">
                  <div>
                    <p className="text-xs opacity-80 mb-2">Progress</p>
                    <div className="flex items-center">
                      <div className="w-full bg-P200 rounded-full h-6 mr-8">
                        <div 
                          className="bg-N00 h-6 rounded-full" 
                          style={{ width: menteeData.progress }}
                        ></div>
                      </div>
                      <span className="text-sm font-medium">{menteeData.progress}</span>
                    </div>
                  </div>
                  
                  <div>
                    <p className="text-xs opacity-80 mb-2">Last Active</p>
                    <p className="text-sm font-medium">
                      {menteeData.last_active ? getLastActiveTime(menteeData.last_active) : "Not available"}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          {/* Tabs */}
          <div className="bg-N00 rounded-lg shadow-xl mb-32 overflow-hidden">
            <div className="flex border-b border-N50">
              <button 
                onClick={() => setSelectedTab("overview")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  selectedTab === "overview" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                Overview
              </button>
              <button 
                onClick={() => setSelectedTab("progress")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  selectedTab === "progress" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                Course Progress
              </button>
              <button 
                onClick={() => setSelectedTab("tasks")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  selectedTab === "tasks" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                Tasks & Assignments
              </button>
              <button 
                onClick={() => setSelectedTab("assessments")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  selectedTab === "assessments" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                Assessments
              </button>
            </div>
            
            {/* Tab Content */}
            <div className="p-24">
              {selectedTab === "overview" && (
                <div>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-24">
                    {/* Bio Section */}
                    <div className="bg-N50 p-20 rounded-lg">
                      <h3 className="text-base font-semibold text-N500 mb-12">About</h3>
                      <p className="text-sm text-N300">{menteeData.bio}</p>
                    </div>
                    
                    {/* Statistics Section */}
                    <div className="bg-N50 p-20 rounded-lg">
                      <h3 className="text-base font-semibold text-N500 mb-12">Progress Summary</h3>
                      <div className="space-y-12">
                        <div className="flex justify-between text-sm">
                          <span className="text-N200">Courses Completed:</span>
                          <span className="text-N500 font-medium">
                            {menteeData.courses.filter(course => course.progress === "100%").length}/{menteeData.courses.length}
                          </span>
                        </div>
                        <div className="flex justify-between text-sm">
                          <span className="text-N200">Tasks Completed:</span>
                          <span className="text-N500 font-medium">
                            {menteeData.tasks.filter(task => task.status === "completed").length}/{menteeData.tasks.length}
                          </span>
                        </div>
                        <div className="flex justify-between text-sm">
                          <span className="text-N200">Assessments:</span>
                          <span className="text-N500 font-medium">
                            {menteeData.assessments.filter(assessment => assessment.status === "completed").length}/{menteeData.assessments.length}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                  
                  {/* Feedback Section */}
                  <div className="bg-N50 p-20 rounded-lg mt-24">
                    <h3 className="text-base font-semibold text-N500 mb-12">Send Feedback</h3>
                    <div>
                      <textarea
                        value={feedbackMessage}
                        onChange={(e) => setFeedbackMessage(e.target.value)}
                        placeholder="Write your feedback or message to the mentee..."
                        className="w-full p-12 border border-N100 rounded-lg mb-12 text-sm text-N500 min-h-120"
                      ></textarea>
                      <div className="flex justify-end">
                        <button
                          onClick={sendFeedback}
                          disabled={!feedbackMessage.trim()}
                          className={`py-8 px-16 rounded-lg text-sm font-medium ${
                            feedbackMessage.trim()
                              ? "bg-P300 text-N00 hover:bg-P200"
                              : "bg-N100 text-N300 cursor-not-allowed"
                          } transition duration-300`}
                        >
                          Send Feedback
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              )}
              
              {selectedTab === "progress" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Course Progress</h2>
                  
                  {menteeData.courses.length === 0 ? (
                    <div className="text-center py-32">
                      <p className="text-N200">No courses available for this mentee.</p>
                    </div>
                  ) : (
                    <div className="space-y-16">
                      {menteeData.courses.map((course) => (
                        <div key={course.id} className="bg-N50 p-20 rounded-lg">
                          <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-12">
                            <h3 className="text-base font-semibold text-N500">{course.name}</h3>
                            <span className="text-sm font-medium text-N400">
                              {course.completed_modules}/{course.total_modules} modules completed
                            </span>
                          </div>
                          
                          <div className="flex items-center">
                            <div className="w-full bg-N100 rounded-full h-8 mr-12">
                              <div 
                                className="bg-P300 h-8 rounded-full" 
                                style={{ width: course.progress }}
                              ></div>
                            </div>
                            <span className="text-sm font-medium">{course.progress}</span>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}
              
              {selectedTab === "tasks" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Tasks & Assignments</h2>
                  
                  {menteeData.tasks.length === 0 ? (
                    <div className="text-center py-32">
                      <p className="text-N200">No tasks assigned to this mentee.</p>
                    </div>
                  ) : (
                    <div className="space-y-16">
                      {menteeData.tasks.map((task) => (
                        <div key={task.id} className="bg-N50 p-20 rounded-lg">
                          <div className="flex flex-col sm:flex-row sm:items-start justify-between mb-12">
                            <div>
                              <div className="flex items-center mb-8">
                                <h3 className="text-base font-semibold text-N500 mr-8">{task.title}</h3>
                                <span className={`text-xs py-2 px-8 rounded-full ${getStatusColor(task.status)}`}>
                                  {task.status === "completed" ? "Completed" : 
                                   task.status === "in_progress" ? "In Progress" : "Pending"}
                                </span>
                              </div>
                              <p className="text-sm text-N300 mb-8">{task.description}</p>
                            </div>
                            <div className="text-right text-sm mt-8 sm:mt-0">
                              <p className="text-N200">Due: {formatDate(task.due_date)}</p>
                              {task.completed_date && (
                                <p className="text-N200">Completed: {formatDate(task.completed_date)}</p>
                              )}
                            </div>
                          </div>
                          
                          {task.status !== "completed" && (
                            <div className="mt-16 pt-16 border-t border-N100">
                              <textarea
                                value={taskNote}
                                onChange={(e) => setTaskNote(e.target.value)}
                                placeholder="Add a note or feedback for this task..."
                                className="w-full p-12 border border-N100 rounded-lg mb-12 text-sm text-N500"
                              ></textarea>
                              <div className="flex justify-end">
                                <button
                                  onClick={() => addTaskNote(task.id)}
                                  disabled={!taskNote.trim()}
                                  className={`py-8 px-16 rounded-lg text-sm font-medium ${
                                    taskNote.trim()
                                      ? "bg-P300 text-N00 hover:bg-P200"
                                      : "bg-N100 text-N300 cursor-not-allowed"
                                  } transition duration-300`}
                                >
                                  Add Note
                                </button>
                              </div>
                            </div>
                          )}
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}
              
              {selectedTab === "assessments" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Assessments</h2>
                  
                  {menteeData.assessments.length === 0 ? (
                    <div className="text-center py-32">
                      <p className="text-N200">No assessments available for this mentee.</p>
                    </div>
                  ) : (
                    <div className="overflow-x-auto">
                      <table className="min-w-full bg-N00">
                        <thead>
                          <tr className="bg-N50">
                            <th className="py-12 px-16 text-left text-sm font-medium text-N400">Assessment</th>
                            <th className="py-12 px-16 text-left text-sm font-medium text-N400">Status</th>
                            <th className="py-12 px-16 text-left text-sm font-medium text-N400">Score</th>
                            <th className="py-12 px-16 text-left text-sm font-medium text-N400">Date</th>
                          </tr>
                        </thead>
                        <tbody className="divide-y divide-N50">
                          {menteeData.assessments.map((assessment) => (
                            <tr key={assessment.id} className="hover:bg-N50 transition duration-150">
                              <td className="py-12 px-16 text-sm font-medium text-N500">{assessment.title}</td>
                              <td className="py-12 px-16">
                                <span className={`text-xs py-2 px-8 rounded-full ${getStatusColor(assessment.status)}`}>
                                  {assessment.status === "completed" ? "Completed" : "Pending"}
                                </span>
                              </td>
                              <td className="py-12 px-16 text-sm text-N400">{assessment.score || "N/A"}</td>
                              <td className="py-12 px-16 text-sm text-N400">{formatDate(assessment.date)}</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>
        </main>
        
        {/* Footer */}
        <footer className="bg-N500 text-N00 py-32">
          <div className="container mx-auto px-16 lg:px-48">
            <div className="flex flex-col md:flex-row justify-between items-center">
              <div className="mb-24 md:mb-0">
                <Image src={Logo} alt="MAP-logo" className="h-auto w-auto" />
                <p className="text-xs text-N100 mt-8">© 2025 Milsat Aspirant Program. All rights reserved.</p>
              </div>
              
              <div className="flex space-x-16">
                <Link href="/mentor-dashboard" className="text-sm text-N100 hover:text-N00">Dashboard</Link>
                <Link href="/mentor-resources" className="text-sm text-N100 hover:text-N00">Resources</Link>
                <Link href="/support" className="text-sm text-N100 hover:text-N00">Support</Link>
              </div>
            </div>
          </div>
        </footer>
      </div>
    </>
  );
};

export default MenteeDetail;