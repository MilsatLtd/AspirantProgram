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
    classUrl: "",
    track: "",
    trackId: "",
    cohort: "",
    profilePicture: ""
  });
  const [mentees, setMentees] = useState([]);
  const [trackData, setTrackData] = useState({
    name: "",
    id: "",
  });
  const [trackCourses, setTrackCourses] = useState([]);
  const [cohortData, setCohortData] = useState({
    name: "",
    id: "",
    duration: 0
  });
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

  const fetchMentorData = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem("token");
      const userId = localStorage.getItem("userId");
      
      if (!token || !userId) {
        throw new Error("Authentication required");
      }
      
      // First try to get the most recent track
      try {
        const recentTrackResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/recent/${userId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        if (recentTrackResponse.data && recentTrackResponse.data.track) {
          // We have a track ID, get detailed info
          const trackId = recentTrackResponse.data.track;
          const mentorResponse = await axios.get(
            `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}/${trackId}`,
            { headers: { Authorization: `Bearer ${token}` } }
          );
          
          // Set track data
          setTrackData({
            name: mentorResponse.data.track?.name || "Unassigned",
            id: trackId,
          });
          
          // Fetch track courses
          try {
            const trackDetailsResponse = await axios.get(
              `${process.env.NEXT_PUBLIC_API_ROUTE}tracks/${trackId}`,
              { headers: { Authorization: `Bearer ${token}` } }
            );
            
            if (trackDetailsResponse.data && trackDetailsResponse.data.courses) {
              // Sort courses by order
              const sortedCourses = [...trackDetailsResponse.data.courses].sort(
                (a, b) => (a.order || Infinity) - (b.order || Infinity)
              );
              setTrackCourses(sortedCourses);
            }
          } catch (error) {
            console.error("Error fetching track courses:", error);
          }
          
          // Set cohort data
          setCohortData({
            name: mentorResponse.data.cohort?.name || "Current Cohort",
            id: mentorResponse.data.cohort?.cohort_id || "",
            duration: mentorResponse.data.cohort?.cohort_duration || 0
          });
          
          // Update user data
          setUserData({
            name: mentorResponse.data.full_name || "Mentor",
            email: mentorResponse.data.email || "",
            bio: mentorResponse.data.bio || "",
            classUrl: mentorResponse.data.class_url || "",
            track: mentorResponse.data.track?.name || "Unassigned",
            trackId: trackId,
            cohort: mentorResponse.data.cohort?.name || "Current Cohort",
            profilePicture: mentorResponse.data.profile_picture || "",
          });
          
          // Set mentees
          setMentees(mentorResponse.data.mentees || []);
        } else {
          throw new Error("No track found");
        }
      } catch (error) {
        // Fallback to basic mentor data
        const basicMentorResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        // Set track data
        const currentTrackId = basicMentorResponse.data.track?.track_id || "";
        setTrackData({
          name: basicMentorResponse.data.track?.name || "Unassigned",
          id: currentTrackId,
        });
        
        // Fetch track courses if we have a track ID
        if (currentTrackId) {
          try {
            const trackDetailsResponse = await axios.get(
              `${process.env.NEXT_PUBLIC_API_ROUTE}tracks/${currentTrackId}`,
              { headers: { Authorization: `Bearer ${token}` } }
            );
            
            if (trackDetailsResponse.data && trackDetailsResponse.data.courses) {
              // Sort courses by order
              const sortedCourses = [...trackDetailsResponse.data.courses].sort(
                (a, b) => (a.order || Infinity) - (b.order || Infinity)
              );
              setTrackCourses(sortedCourses);
            }
          } catch (error) {
            console.error("Error fetching track courses:", error);
          }
        }
        
        // Set cohort data
        setCohortData({
          name: basicMentorResponse.data.cohort?.name || "Current Cohort",
          id: basicMentorResponse.data.cohort?.cohort_id || "",
          duration: basicMentorResponse.data.cohort?.cohort_duration || 0
        });
        
        setUserData({
          name: basicMentorResponse.data.full_name || "Mentor",
          email: basicMentorResponse.data.email || "",
          bio: basicMentorResponse.data.bio || "",
          classUrl: basicMentorResponse.data.class_url || "",
          track: basicMentorResponse.data.track?.name || "Unassigned",
          trackId: currentTrackId,
          cohort: basicMentorResponse.data.cohort?.name || "Current Cohort",
          profilePicture: basicMentorResponse.data.profile_picture || "",
        });
        
        setMentees(basicMentorResponse.data.mentees || []);
      }
    } catch (err) {
      console.error("Error fetching mentor data:", err);
      
      if (err.response && err.response.status === 401) {
        // Token expired
        localStorage.removeItem("token");
        localStorage.removeItem("refreshToken");
        router.push("/login");
        return;
      }
      
      setError(err.message || "Failed to load mentor data");
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("refreshToken");
    localStorage.removeItem("userId");
    localStorage.removeItem("userRole");
    router.push("/login");
  };

  // Function to check if a link is YouTube
  const isYoutubeLink = (url) => {
    return url && (
      url.includes('youtube.com') || 
      url.includes('youtu.be')
    );
  };

  // Function to convert YouTube link to embed format
  const getYoutubeEmbedLink = (url) => {
    if (!url) return null;
    
    // Handle youtu.be format
    if (url.includes('youtu.be')) {
      const videoId = url.split('youtu.be/')[1].split('?')[0];
      return `https://www.youtube.com/embed/${videoId}`;
    }
    
    // Handle youtube.com format
    if (url.includes('youtube.com/watch')) {
      const videoId = new URL(url).searchParams.get('v');
      return `https://www.youtube.com/embed/${videoId}`;
    }
    
    return url;
  };

  // Function to handle profile picture upload
  const handleProfilePictureUpload = async (event) => {
    const file = event.target.files[0];
    if (!file) return;
    
    const token = localStorage.getItem("token");
    const userId = localStorage.getItem("userId");
    
    if (!token || !userId) {
      alert("Authentication required");
      return;
    }
    
    try {
      const formData = new FormData();
      formData.append('profile_picture', file);
      
      const response = await axios.post(
        `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}/upload-picture`,
        formData,
        { 
          headers: { 
            Authorization: `Bearer ${token}`,
            'Content-Type': 'multipart/form-data'
          } 
        }
      );
      
      if (response.data && response.data.profile_picture) {
        setUserData(prev => ({
          ...prev,
          profilePicture: response.data.profile_picture
        }));
        alert("Profile picture updated successfully");
      }
    } catch (err) {
      console.error("Error uploading profile picture:", err);
      alert("Failed to upload profile picture");
    }
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
                  onClick={() => setActiveTab("trackDetails")}
                  className="bg-N00 text-P300 py-8 px-16 rounded-lg font-medium text-sm hover:bg-N50 transition duration-300"
                >
                  View Track Details
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
                onClick={() => setActiveTab("trackDetails")}
                className={`flex-1 py-16 text-center font-medium text-sm ${
                  activeTab === "trackDetails" 
                    ? "text-P300 border-b-2 border-P300" 
                    : "text-N300 hover:text-P200"
                }`}
              >
                Track Details
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
              {/* Mentees Tab */}
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
                                onClick={() => router.push(`/mentor-dashboard/mentee/${mentee.user_id}`)}
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
              
              {/* Track Details Tab */}
              {activeTab === "trackDetails" && (
                <div>
                  <h2 className="text-lg font-bold text-N500 mb-24">Track & Cohort Information</h2>
                  
                  <div className="grid grid-cols-1 gap-24">
                    {/* Cohort Information - Now appears first */}
                    <div className="bg-N50 rounded-lg p-24 shadow-lg">
                      <h3 className="text-base font-semibold text-N500 mb-16">Cohort Details</h3>
                      
                      <div className="space-y-12">
                        <div className="flex justify-between">
                          <span className="text-sm text-N300">Cohort Name:</span>
                          <span className="text-sm font-medium text-N500">{cohortData.name}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-sm text-N300">Duration:</span>
                          <span className="text-sm font-medium text-N500">{cohortData.duration} {cohortData.duration === 1 ? 'month' : 'months'}</span>
                        </div>
                      </div>
                    </div>
                    
                    {/* Track Information */}
                    <div className="bg-N50 rounded-lg p-24 shadow-lg">
                      <h3 className="text-base font-semibold text-N500 mb-16">Track Details</h3>
                      
                      <div className="space-y-12 mb-24">
                        <div className="flex justify-between">
                          <span className="text-sm text-N300">Track Name:</span>
                          <span className="text-sm font-medium text-N500">{trackData.name}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-sm text-N300">Your Mentees:</span>
                          <span className="text-sm font-medium text-N500">{mentees.length}</span>
                        </div>
                      </div>
                      
                      {/* Track Courses */}
                      <div>
                        <h4 className="text-base font-semibold text-N400 mb-16 border-b border-N100 pb-8">Track Courses</h4>
                        
                        {trackCourses.length === 0 ? (
                          <p className="text-sm text-N200">No courses found for this track.</p>
                        ) : (
                          <div className="space-y-24">
                            {trackCourses.map((course, index) => (
                              <div key={index} className="bg-N00 p-16 rounded-lg shadow-sm">
                                <div className="flex justify-between items-start mb-8">
                                  <h5 className="text-sm font-bold text-N500">
                                    {course.order && `${course.order}. `}{course.name}
                                  </h5>
                                </div>
                                <p className="text-sm text-N300 mb-12">{course.description}</p>
                                
                                {course.requirements && (
                                  <div className="mb-12">
                                    <span className="text-sm font-semibold text-N500">Requirements:</span>
                                    <p className="text-sm text-N400">{course.requirements}</p>
                                  </div>
                                )}
                                
                                {course.access_link && (
                                  <div>
  {/* <span className="text-sm font-semibold text-N400 block mb-8">Access:</span> */}
  {isYoutubeLink(course.access_link) ? (
    <div className="mt-8 w-full" style={{ position: 'relative', paddingBottom: '56.25%', height: 0, overflow: 'hidden' }}>
      <iframe
        src={getYoutubeEmbedLink(course.access_link)}
        title={course.name}
        frameBorder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowFullScreen
        style={{ position: 'absolute', top: 0, left: 0, width: '100%', height: '100%' }}
        className="rounded"
      ></iframe>
    </div>
  ) : (
    <a
      href={course.access_link}
      target="_blank"
      rel="noopener noreferrer"
      className="text-P300 hover:text-P200 text-sm inline-flex items-center"
    >
      <svg xmlns="http://www.w3.org/2000/svg" className="h-16 w-16 mr-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
      </svg>
      Open Course Material
    </a>
  )}
</div>
                                )}
                              </div>
                            ))}
                          </div>
                        )}
                      </div>
                    </div>
                  </div>
                </div>
              )}
              
              {/* Profile Tab */}
              {activeTab === "profile" && (
  <div>
    <h2 className="text-lg font-bold text-N500 mb-24">Mentor Profile</h2>
    
    <div className="bg-N50 rounded-lg p-24">
      <div className="flex flex-col md:flex-row items-start gap-24">
        <div className="w-80 h-80 rounded-full overflow-hidden bg-P50 flex-shrink-0 relative group">
          {/* {userData.profilePicture ? (
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
          )} */}
          
          {/* Image upload overlay */}
          <div className="absolute inset-0 bg-N500 bg-opacity-50 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity cursor-pointer">
            <label htmlFor="profile-upload" className="cursor-pointer">
              <svg xmlns="http://www.w3.org/2000/svg" className="h-24 w-24 text-N00" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z" />
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 13a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
            </label>
            <input 
              id="profile-upload"
              type="file"
              accept="image/*"
              className="hidden"
              onChange={handleProfilePictureUpload}
            />
          </div>
        </div>
        
        <div className="flex-1">
          <h3 className="text-xl font-bold text-N500 mb-8">{userData.name}</h3>
          <p className="text-sm text-N300 mb-8">{userData.email}</p>
          
          {/* Bio Section - Enhanced */}
          <div className="bg-N100 p-16 rounded-lg mb-16">
            <h4 className="text-sm font-semibold text-N500 mb-8">About Me</h4>
            {userData.bio ? (
              <p className="text-sm text-N300">{userData.bio}</p>
            ) : (
              <div className="flex items-center justify-between">
                <p className="text-sm text-N200 italic">No bio available</p>
                <Link href="/mentor-dashboard/edit-profile">
                  <span className="text-sm text-P500 hover:text-P200 cursor-pointer">Add Bio</span>
                </Link>
              </div>
            )}
          </div>
          
          {/* Class URL Section - New */}
          <div className="bg-N100 p-16 rounded-lg mb-16">
            <h4 className="text-sm font-semibold text-N400 mb-8">Virtual Classroom</h4>
            {userData.classUrl ? (
              <div className="flex items-center justify-between">
                <p className="text-sm text-N300 truncate max-w-xs">{userData.classUrl}</p>
                <a 
                  href={userData.classUrl}
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="text-xs bg-P50 text-P300 px-8 py-4 rounded hover:bg-P100 transition duration-300"
                >
                  Open
                </a>
              </div>
            ) : (
              <div className="flex items-center justify-between">
                <p className="text-sm text-N200 italic">No classroom link set</p>
                <Link href="/mentor-dashboard/edit-profile">
                  <span className="text-sm text-P500 hover:text-P200 cursor-pointer">Add Link</span>
                </Link>
              </div>
            )}
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
          </div>
          
          <div className="mt-24">
            <button 
              onClick={() => router.push("/mentor-dashboard/edit-profile")}
              className="bg-P50 text-P300 py-12 px-20 rounded-lg text-sm font-medium hover:bg-P100 transition duration-300"
            >
              Edit Profile
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