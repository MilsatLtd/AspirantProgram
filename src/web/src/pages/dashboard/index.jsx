import { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import Head from "next/head";
import axios from "axios";
import { useRouter } from "next/router";
import Logo from "../../Assets/logo.svg";

const StudentDashboard = () => {
  const router = useRouter();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [userData, setUserData] = useState({
    name: "",
    cohort: "",
    track: "",
    trackId: "",
    studentId: "",
  });
  const [courses, setCourses] = useState([]);
  const [mentor, setMentor] = useState({
    name: "",
    bio: "",
    whatsappLink: "",
    avatar: "",
  });
  const [activeTab, setActiveTab] = useState("courses");

  // Add useEffect to trigger data fetching when component mounts
  useEffect(() => {
    const token = localStorage.getItem("token");
    
    if (!token) {
      router.push("/login");
      return;
    }
    
    fetchStudentData();
  }, []);
  
  const ensureSafeRender = (value) => {
    if (value === null || value === undefined) {
      return '';
    }
    if (typeof value === 'object') {
      if (value.name) {
        return value.name; 
      }
      return JSON.stringify(value); 
    }
    return value;
  };

  // Logout handler function
  const handleLogout = () => {
    // Clear all authentication data from localStorage
    localStorage.removeItem("token");
    localStorage.removeItem("refreshToken");
    localStorage.removeItem("userId");
    
    // Redirect to login page
    router.push("/login");
  };

  const fetchStudentData = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem("token");
      
      if (!token) {
        throw new Error("Authentication required");
      }
      
      // Get user ID from token or local storage
      const userId = localStorage.getItem("userId") || getUserIdFromToken(token);
      
      if (!userId) {
        throw new Error("Invalid authentication token");
      }
      
      // Store userId in localStorage if not already there
      if (!localStorage.getItem("userId")) {
        localStorage.setItem("userId", userId);
      }
      
      console.log("User ID for API requests:", userId);
      
      try {
        // Step 1: Try to get the user's most recent track
        const recentTrackResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}students/recent/${userId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        console.log("Recent track response:", recentTrackResponse.data);
        
        let trackId;
        // Check if we have a valid track from the recent endpoint
        if (recentTrackResponse.data && recentTrackResponse.data.track) {
          trackId = recentTrackResponse.data.track;
          console.log("Using track from recent response:", trackId);
        } else {
          console.log("No track in recent response, trying alternative approach");
          
          // Step 2: If no recent track, get student info to find any track_id
          const studentResponse = await axios.get(
            `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}`,
            { headers: { Authorization: `Bearer ${token}` } }
          );
          
          console.log("Student response:", studentResponse.data);
          
          // Check if the response includes track information we can use
          if (studentResponse.data && studentResponse.data.track && studentResponse.data.track.track_id) {
            trackId = studentResponse.data.track.track_id;
            console.log("Found track_id in student data:", trackId);
          } else {
            console.log("No track_id found in any response");
            
            // Step 3: No track found, set default data from student info
            handleNoTrackScenario(studentResponse.data, userId);
            return;
          }
        }
        
        // Step 4: We have a track ID, fetch detailed data
        await fetchStudentDataWithTrack(userId, trackId, token);
        
      } catch (error) {
        console.error("Error in data fetching flow:", error);
        
        // Try one more approach - just get basic student data
        try {
          const basicStudentResponse = await axios.get(
            `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}`,
            { headers: { Authorization: `Bearer ${token}` } }
          );
          
          handleNoTrackScenario(basicStudentResponse.data, userId);
        } catch (finalError) {
          console.error("Failed to get any student data:", finalError);
          setError("Could not retrieve your student information. Please try again later.");
          setLoading(false);
        }
      }
    } catch (err) {
      console.error("Overall error:", err);
      
      if (err.response && err.response.status === 401) {
        // Token expired
        localStorage.removeItem("token");
        localStorage.removeItem("refreshToken");
        router.push("/login");
        return;
      }
      
      setError(err.message || "Failed to load student data");
      setLoading(false);
    }
  };
  
  const handleNoTrackScenario = (studentData, userId) => {
    // Set default data when no track is found
    setUserData({
      name: studentData?.full_name || "Student",
      cohort: ensureSafeRender(studentData?.cohort) || "Current Cohort",
      track: "Unassigned",
      trackId: "default",
      studentId: userId,
    });
    
    setCourses([]);
    
    if (studentData?.mentor) {
      const mentorData = studentData.mentor;
      setMentor({
        name: typeof mentorData === 'object' ? mentorData.full_name || "Mentor" : String(mentorData),
        bio: typeof mentorData === 'object' ? mentorData.bio || "Mentor information" : "Mentor information",
        whatsappLink: "#",
        avatar: studentData.profile_picture || "/api/placeholder/80/80",
      });
    }
    
    setLoading(false);
  };
  
  const fetchStudentDataWithTrack = async (userId, trackId, token) => {
    try {
      // Fetch student data with the track
      const userResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}/${trackId}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      console.log("Student data with track:", userResponse.data);
      
      // Fetch courses for the student's track
      const coursesResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}students/courses/${userId}/${trackId}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      console.log("Courses data:", coursesResponse.data);
      
      // Update user data
      setUserData({
        name: userResponse.data.full_name || "Student",
        cohort: ensureSafeRender(userResponse.data.cohort) || "Current Cohort",
        track: userResponse.data.track ? ensureSafeRender(userResponse.data.track) : "General",
        trackId: trackId,
        studentId: userId,
      });
      
      // Update courses
      setCourses(coursesResponse.data.courses || []);
      
      // Update mentor information
      if (userResponse.data.mentor) {
        const mentorData = userResponse.data.mentor;
        setMentor({
          name: typeof mentorData === 'object' ? mentorData.full_name || "Mentor" : String(mentorData),
          bio: typeof mentorData === 'object' ? mentorData.bio || "Mentor information" : "Mentor information",
          whatsappLink: "#",
          avatar: mentorData.profile_picture || "/api/placeholder/80/80",
        });
      }
    } catch (error) {
      console.error("Error fetching student data with track:", error);
      setError("Error loading data with track information");
    } finally {
      setLoading(false);
    }
  };
  
  // Helper function to extract user ID from token
  const getUserIdFromToken = (token) => {
    try {
      // JWT tokens are in format: header.payload.signature
      const parts = token.split('.');
      
      if (parts.length !== 3) {
        console.error("Invalid token format");
        return null;
      }
      
      const payload = parts[1];
      
      // Base64 decode the payload
      const base64 = payload.replace(/-/g, '+').replace(/_/g, '/');
      const decodedPayload = JSON.parse(atob(base64));
      
      return decodedPayload.user_id;
    } catch (error) {
      console.error("Error decoding token:", error);
      return null;
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-N50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-t-4 border-b-4 border-P300 mx-auto"></div>
          <p className="mt-16 font-medium text-N300">Loading student dashboard...</p>
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
          <h3 className="text-xl font-bold text-N500 mb-8">Error Loading Dashboard</h3>
          <p className="text-N300 mb-16">{error}</p>
          <Link href="/login">
            <button className="w-full bg-P300 text-N00 py-12 px-24 rounded-lg hover:bg-P200 transition duration-300 font-semibold">
              Back to Login
            </button>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <>
      <Head>
        <title>Student Dashboard | Milsat Aspirant Program</title>
      </Head>
      
      <div className="min-h-screen bg-N50">
        {/* Header/Navigation */}
        <header className="bg-N00 shadow-xl">
          <div className="container mx-auto px-16 lg:px-48">
            <div className="flex items-center justify-between py-16">
              <Link href="/dashboard">
                <div className="inline-block">
                  <Image src={Logo} alt="MAP-logo" className="h-auto w-auto" />
                </div>
              </Link>
              
              <div className="flex items-center space-x-16">
                <div className="text-right mr-16">
                  <p className="text-sm font-medium text-N300">{userData.name}</p>
                  <p className="text-xs text-N200">{userData.track} Track</p>
                </div>
                <div className="bg-P300 text-N00 rounded-full w-40 h-40 flex items-center justify-center">
                  <span className="font-semibold">{userData.name ? userData.name.charAt(0) : ''}</span>
                </div>
                <button 
                  onClick={handleLogout}
                  className="text-sm font-medium text-N400 hover:text-R300 transition duration-300 flex items-center"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-16 w-16 mr-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                  </svg>
                  Logout
                </button>
              </div>
            </div>
          </div>
        </header>
        
        {/* Main Content */}
        <main className="container mx-auto px-16 lg:px-48 py-32">
          {/* Cohort Information */}
          <div className="bg-P300 text-N00 rounded-lg p-24 mb-32 shadow-card">
            <div className="flex flex-col md:flex-row md:items-center justify-between">
              <div>
                <h1 className="text-xl font-bold mb-8">Welcome to {userData.cohort}</h1>
                <p className="text-sm opacity-90">Track: {userData.track}</p>
              </div>
              <div className="mt-16 md:mt-0">
                <button 
                  onClick={() => setActiveTab("mentor")}
                  className="bg-N00 text-P300 py-8 px-16 rounded-lg font-medium text-sm hover:bg-N50 transition duration-300"
                >
                  View Assigned Mentor
                </button>
              </div>
            </div>
          </div>
          
          {/* Tabs */}
          <div className="bg-N00 rounded-lg shadow-xl mb-32">
            <div className="flex border-b border-N50">
              <button 
                onClick={() => setActiveTab("courses")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  activeTab === "courses" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                My Courses
              </button>
              <button 
                onClick={() => setActiveTab("mentor")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  activeTab === "mentor" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                Assigned Mentor
              </button>
            </div>
            
            {/* Tab Content */}
            <div className="p-24">
              {activeTab === "courses" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Available Courses</h2>
                  
                  {courses.length === 0 ? (
                    <div className="text-center py-48">
                      <p className="text-N200">No courses are currently available for your track.</p>
                    </div>
                  ) : (
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-24">
                      {courses.map((course, index) => (
                        <div key={index} className="bg-N50 rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition duration-300">
                          <div className="aspect-video bg-N100 relative">
                            {course.thumbnail ? (
                              <Image 
                                src={course.thumbnail} 
                                alt={course.name}
                                layout="fill"
                                objectFit="cover"
                              />
                            ) : (
                              <div className="w-full h-full flex items-center justify-center bg-P50">
                                <span className="text-P300 font-medium">{course.name?.charAt(0)}</span>
                              </div>
                            )}
                          </div>
                          
                          <div className="p-16">
                            <h3 className="text-base font-semibold text-N500 mb-8">{course.name}</h3>
                            <p className="text-sm text-N200 mb-16">{course.description}</p>
                            
                            <Link href={`/tracks/${userData.trackId}?course=${course.course_id}`}>
  <button className="w-full bg-P300 text-N00 py-8 px-16 rounded-lg text-sm font-medium hover:bg-P200 transition duration-300">
    View Course
  </button>
</Link>
                            
                            {/* Original code with conditional rendering based on course.can_view
                            {course.can_view ? (
                              <Link href={`/courses/${course.course_id}`}>
                                <button className="w-full bg-P300 text-N00 py-8 px-16 rounded-lg text-sm font-medium hover:bg-P200 transition duration-300">
                                  View Course
                                </button>
                              </Link>
                            ) : (
                              <button 
                                disabled
                                className="w-full bg-N100 text-N300 py-8 px-16 rounded-lg text-sm font-medium cursor-not-allowed"
                              >
                                Locked
                              </button>
                            )} */}
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}
              
              {activeTab === "mentor" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Assigned Mentor</h2>
                  
                  <div className="bg-N50 rounded-lg p-24">
                    <div className="flex flex-col md:flex-row items-start gap-24">
                      <div className="w-80 h-80 rounded-full overflow-hidden bg-P50 flex-shrink-0">
                        {mentor.avatar ? (
                          <Image 
                            src={mentor.avatar} 
                            alt={mentor.name}
                            width={80}
                            height={80}
                            className="w-full h-full object-cover"
                          />
                        ) : (
                          <div className="w-full h-full flex items-center justify-center bg-P300 text-N00">
                            <span className="font-semibold text-lg">{mentor.name.charAt(0)}</span>
                          </div>
                        )}
                      </div>
                      
                      <div className="flex-1">
                        <h3 className="text-xl font-bold text-N500 mb-8">{mentor.name}</h3>
                        <p className="text-sm text-N300 mb-16">{mentor.bio}</p>
                        
                        {mentor.whatsappLink && (
                          <a 
                            href={mentor.whatsappLink} 
                            target="_blank" 
                            rel="noopener noreferrer"
                            className="inline-flex items-center text-sm font-medium text-P300 hover:text-P200 transition"
                          >
                            {/* Changed from WhatsApp icon to a class/group icon */}
                            <svg xmlns="http://www.w3.org/2000/svg" className="h-16 w-16 mr-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                            </svg>
                            Join Class Group
                          </a>
                        )}
                      </div>
                    </div>
                  </div>
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
                <Link href="/dashboard" className="text-sm text-N100 hover:text-N00">Dashboard</Link>
                <Link href="/course" className="text-sm text-N100 hover:text-N00">Courses</Link>
                <Link href="/support" className="text-sm text-N100 hover:text-N00">Support</Link>
              </div>
            </div>
          </div>
        </footer>
      </div>
    </>
  );
};

export default StudentDashboard;