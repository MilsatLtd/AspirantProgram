import { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import Head from "next/head";
import axios from "axios";
import { useRouter } from "next/router";
import Logo from "../../Assets/logo.svg";

const MentorDashboard = () => {
  const router = useRouter();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [userData, setUserData] = useState({
    name: "",
    email: "",
    bio: "",
    track: "",
    trackId: "",
    cohort: "",
    profilePicture: "",
  });
  const [mentees, setMentees] = useState([]);
  const [courses, setCourses] = useState([]);
  const [activeTab, setActiveTab] = useState("mentees");

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
    
    fetchMentorData();
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

  const fetchMentorData = async () => {
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
      
      try {
        // Step 1: Try to get the most recent track for the mentor
        const recentTrackResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/recent/${userId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        console.log("Recent track response:", recentTrackResponse.data);
        
        let trackId;
        // Check if we have a valid track from the recent endpoint
        if (recentTrackResponse.data && recentTrackResponse.data.track_id) {
          trackId = recentTrackResponse.data.track_id;
          console.log("Using track from recent response:", trackId);
        } else {
          console.log("No track in recent response, trying alternative approach");
          
          // Step 2: If no recent track, get mentor info
          const mentorResponse = await axios.get(
            `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}`,
            { headers: { Authorization: `Bearer ${token}` } }
          );
          
          console.log("Mentor response:", mentorResponse.data);
          
          // Set default data from mentor info
          handleBasicMentorData(mentorResponse.data, userId);
          return;
        }
        
        // Step 3: We have a track ID, fetch detailed data
        await fetchMentorDataWithTrack(userId, trackId, token);
        
      } catch (error) {
        console.error("Error in data fetching flow:", error);
        
        // Try one more approach - just get basic mentor data
        try {
          const basicMentorResponse = await axios.get(
            `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}`,
            { headers: { Authorization: `Bearer ${token}` } }
          );
          
          handleBasicMentorData(basicMentorResponse.data, userId);
        } catch (finalError) {
          console.error("Failed to get any mentor data:", finalError);
          setError("Could not retrieve your mentor information. Please try again later.");
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
      
      setError(err.message || "Failed to load mentor data");
      setLoading(false);
    }
  };
  
  const handleBasicMentorData = (mentorData, userId) => {
    // Set basic mentor data
    setUserData({
      name: mentorData?.full_name || "Mentor",
      email: mentorData?.email || "",
      bio: mentorData?.bio || "",
      track: ensureSafeRender(mentorData?.track) || "Unassigned",
      trackId: "default",
      cohort: ensureSafeRender(mentorData?.cohort) || "Current Cohort",
      profilePicture: mentorData?.profile_picture || "",
    });
    
    // Parse mentees if available
    if (mentorData?.mentees) {
      try {
        const parsedMentees = typeof mentorData.mentees === 'string' 
          ? JSON.parse(mentorData.mentees) 
          : Array.isArray(mentorData.mentees) 
            ? mentorData.mentees 
            : [];
            
        setMentees(parsedMentees);
      } catch (e) {
        console.error("Failed to parse mentees:", e);
        setMentees([]);
      }
    }
    
    // Set empty courses
    setCourses([]);
    
    setLoading(false);
  };
  
  const fetchMentorDataWithTrack = async (userId, trackId, token) => {
    try {
      // Fetch mentor data with the track
      const mentorResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}/${trackId}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      console.log("Mentor data with track:", mentorResponse.data);
      
      // Update user data
      setUserData({
        name: mentorResponse.data.full_name || "Mentor",
        email: mentorResponse.data.email || "",
        bio: mentorResponse.data.bio || "",
        track: ensureSafeRender(mentorResponse.data.track) || "Unassigned",
        trackId: trackId,
        cohort: ensureSafeRender(mentorResponse.data.cohort) || "Current Cohort",
        profilePicture: mentorResponse.data.profile_picture || "",
      });
      
      // Parse mentees if available
      if (mentorResponse.data.mentees) {
        try {
          const parsedMentees = typeof mentorResponse.data.mentees === 'string' 
            ? JSON.parse(mentorResponse.data.mentees) 
            : Array.isArray(mentorResponse.data.mentees) 
              ? mentorResponse.data.mentees 
              : [];
              
          setMentees(parsedMentees);
        } catch (e) {
          console.error("Failed to parse mentees:", e);
          setMentees([]);
        }
      }
      
      // Try to fetch courses for the track
      try {
        const coursesResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}tracks/courses/${trackId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        console.log("Courses data:", coursesResponse.data);
        
        // Update courses
        setCourses(coursesResponse.data.courses || []);
      } catch (coursesError) {
        console.error("Failed to fetch courses:", coursesError);
        setCourses([]);
      }
    } catch (error) {
      console.error("Error fetching mentor data with track:", error);
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

  const handleLogout = () => {
    // Clear all auth data from localStorage
    localStorage.removeItem("token");
    localStorage.removeItem("refreshToken");
    localStorage.removeItem("userId");
    localStorage.removeItem("userRole");
    
    // Redirect to login page
    router.push("/login");
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-N50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-t-4 border-b-4 border-P300 mx-auto"></div>
          <p className="mt-16 font-medium text-N300">Loading mentor dashboard...</p>
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
        <title>Mentor Dashboard | Milsat Aspirant Program</title>
      </Head>
      
      <div className="min-h-screen bg-N50">
        {/* Header/Navigation */}
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
                  <p className="text-sm font-medium text-N300">{userData.name}</p>
                  <p className="text-xs text-N200">Mentor - {userData.track} Track</p>
                </div>
                <div className="bg-P300 text-N00 rounded-full w-40 h-40 flex items-center justify-center">
                  {userData.profilePicture ? (
                    <Image 
                      src={userData.profilePicture}
                      alt={userData.name}
                      width={40}
                      height={40}
                      className="rounded-full"
                    />
                  ) : (
                    <span className="font-semibold">{userData.name ? userData.name.charAt(0) : "M"}</span>
                  )}
                </div>
              </div>
            </div>
          </div>
        </header>
        
        {/* Main Content */}
        <main className="container mx-auto px-16 lg:px-48 py-32">
          {/* Mentor Information */}
          <div className="bg-P300 text-N00 rounded-lg p-24 mb-32 shadow-card">
            <div className="flex flex-col md:flex-row md:items-center justify-between">
              <div>
                <h1 className="text-xl font-bold mb-8">Welcome, {userData.name}</h1>
                <p className="text-sm opacity-90">Track: {userData.track} | Cohort: {userData.cohort}</p>
              </div>
              <div className="mt-16 md:mt-0 flex space-x-12">
                <button 
                  onClick={() => setActiveTab("mentees")}
                  className="bg-N00 text-P300 py-8 px-16 rounded-lg font-medium text-sm hover:bg-N50 transition duration-300"
                >
                  View Mentees
                </button>
                <button 
                  onClick={() => setActiveTab("courses")}
                  className="bg-N00 text-P300 py-8 px-16 rounded-lg font-medium text-sm hover:bg-N50 transition duration-300"
                >
                  View Courses
                </button>
              </div>
            </div>
          </div>
          
          {/* Tabs */}
          <div className="bg-N00 rounded-lg shadow-xl mb-32">
            <div className="flex border-b border-N50">
              <button 
                onClick={() => setActiveTab("mentees")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  activeTab === "mentees" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                My Mentees
              </button>
              <button 
                onClick={() => setActiveTab("courses")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  activeTab === "courses" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                Track Courses
              </button>
              <button 
                onClick={() => setActiveTab("profile")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  activeTab === "profile" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                My Profile
              </button>
            </div>
            
            {/* Tab Content */}
            <div className="p-24">
              {activeTab === "mentees" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Assigned Mentees</h2>
                  
                  {mentees.length === 0 ? (
                    <div className="text-center py-48">
                      <p className="text-N200">No mentees are currently assigned to you.</p>
                    </div>
                  ) : (
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-24">
                      {mentees.map((mentee, index) => (
                        <div key={index} className="bg-N50 rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition duration-300">
                          <div className="p-20">
                            <div className="flex items-center mb-16">
                              <div className="w-48 h-48 rounded-full bg-P300 text-N00 flex items-center justify-center mr-12">
                                <span className="font-semibold text-base">
                                  {mentee.full_name ? mentee.full_name.charAt(0) : "S"}
                                </span>
                              </div>
                              <div>
                                <h3 className="text-base font-semibold text-N500">{mentee.full_name}</h3>
                                <p className="text-xs text-N200">{mentee.email}</p>
                              </div>
                            </div>
                            
                            <div className="space-y-8">
                              <div className="flex justify-between text-sm">
                                <span className="text-N200">Progress:</span>
                                <span className="text-N400 font-medium">
                                  {mentee.progress || "0%"}
                                </span>
                              </div>
                              
                              <div className="w-full bg-N100 rounded-full h-6">
                                <div 
                                  className="bg-P300 h-6 rounded-full" 
                                  style={{ width: mentee.progress || "0%" }}
                                ></div>
                              </div>
                            </div>
                            
                            <div className="mt-16 flex justify-end">
                            <button 
  onClick={() => {
    console.log("View mentee:", mentee);
    router.push(`/mentor-dashboard/mentee/${mentee.user_id}`);
  }}
  className="text-sm text-P300 hover:text-P200 font-medium"
>
  View Details
</button>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}
              
              {activeTab === "courses" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Track Courses</h2>
                  
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
                            
                            <Link href={`/courses/${course.course_id}`}>
                              <button className="w-full bg-P300 text-N00 py-8 px-16 rounded-lg text-sm font-medium hover:bg-P200 transition duration-300">
                                View Course
                              </button>
                            </Link>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}
              
              {activeTab === "profile" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Mentor Profile</h2>
                  
                  <div className="bg-N50 rounded-lg p-24">
                    <div className="flex flex-col md:flex-row items-start gap-24">
                      <div className="w-80 h-80 rounded-full overflow-hidden bg-P50 flex-shrink-0">
                        {userData.profilePicture ? (
                          <Image 
                            src={userData.profilePicture} 
                            alt={userData.name}
                            width={80}
                            height={80}
                            className="w-full h-full object-cover"
                          />
                        ) : (
                          <div className="w-full h-full flex items-center justify-center bg-P300 text-N00">
                            <span className="font-semibold text-lg">{userData.name.charAt(0)}</span>
                          </div>
                        )}
                      </div>
                      
                      <div className="flex-1">
                        <h3 className="text-xl font-bold text-N500 mb-8">{userData.name}</h3>
                        <p className="text-sm text-N300 mb-8">{userData.email}</p>
                        <div className="bg-N100 p-16 rounded-lg mb-16">
                          <h4 className="text-sm font-semibold text-N400 mb-8">About Me</h4>
                          <p className="text-sm text-N300">{userData.bio || "No bio available."}</p>
                        </div>
                        
                        <div className="space-y-12">
                          <div className="flex justify-between">
                            <span className="text-sm text-N300">Track:</span>
                            <span className="text-sm font-medium text-N500">{userData.track}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm text-N300">Cohort:</span>
                            <span className="text-sm font-medium text-N500">{userData.cohort}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm text-N300">Assigned Mentees:</span>
                            <span className="text-sm font-medium text-N500">{mentees.length}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm text-N300">Track Courses:</span>
                            <span className="text-sm font-medium text-N500">{courses.length}</span>
                          </div>
                        </div>
                        
                        <div className="flex space-x-16 mt-24">
                          <button 
                            onClick={() => router.push("/mentor-dashboard/edit-profile")}
                            className="flex-1 bg-P50 text-P300 py-12 px-20 rounded-lg text-sm font-medium hover:bg-P100 transition duration-300"
                          >
                            Edit Profile
                          </button>
                          <button 
                            onClick={handleLogout}
                            className="flex-1 bg-R50 text-R300 py-12 px-20 rounded-lg text-sm font-medium hover:bg-R100 transition duration-300"
                          >
                            Logout
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>
          
          {/* Analytics Section */}
          {activeTab === "mentees" && (
            <div className="bg-N00 rounded-lg shadow-xl p-24 mb-32">
              <h2 className="text-lg font-bold text-N500 mb-16">Mentee Analytics</h2>
              
              <div className="grid grid-cols-1 md:grid-cols-3 gap-16">
                <div className="bg-N50 p-16 rounded-lg">
                  <p className="text-sm text-N200 mb-8">Total Mentees</p>
                  <p className="text-2xl font-bold text-N500">{mentees.length}</p>
                </div>
                
                <div className="bg-N50 p-16 rounded-lg">
                  <p className="text-sm text-N200 mb-8">Average Progress</p>
                  <p className="text-2xl font-bold text-N500">
                    {mentees.length > 0 
                      ? Math.round(mentees.reduce((sum, mentee) => sum + parseFloat(mentee.progress || "0"), 0) / mentees.length) + "%"
                      : "0%"
                    }
                  </p>
                </div>
                
                <div className="bg-N50 p-16 rounded-lg">
                  <p className="text-sm text-N200 mb-8">Active This Week</p>
                  <p className="text-2xl font-bold text-N500">
                    {mentees.filter(mentee => mentee.last_active && new Date(mentee.last_active) > new Date(Date.now() - 7 * 24 * 60 * 60 * 1000)).length}
                  </p>
                </div>
              </div>
            </div>
          )}
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

export default MentorDashboard;