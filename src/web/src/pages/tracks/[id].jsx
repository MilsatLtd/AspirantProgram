import { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import { useRouter } from "next/router";
import Head from "next/head";
import axios from "axios";
import Logo from "../../Assets/logo.svg";

const TrackDetail = () => {
  const router = useRouter();
  const { id, course } = router.query; // Get track ID and course ID from URL
  
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [userData, setUserData] = useState({
    name: "",
    cohort: "",
    track: "",
    trackId: "",
    studentId: "",
  });
  const [trackData, setTrackData] = useState({
    name: "",
    description: "",
    courses: []
  });
  const [courseData, setCourseData] = useState({
    title: "",
    description: "",
    requirements: "",
    access_link: "",
    order: 0
  });
  const [currentCourseIndex, setCurrentCourseIndex] = useState(0);
  const [videoError, setVideoError] = useState(false);

  useEffect(() => {
    if (id) {
      const token = localStorage.getItem("token");
      
      if (!token) {
        router.push("/login");
        return;
      }
      
      fetchTrackData();
    }
  }, [id, router]);

  // When course changes in URL, update active course
  useEffect(() => {
    if (trackData.courses && trackData.courses.length > 0 && course) {
      const selectedCourseIndex = trackData.courses.findIndex(c => c.course_id === course);
      if (selectedCourseIndex !== -1) {
        setCurrentCourseIndex(selectedCourseIndex);
        setCourseData(trackData.courses[selectedCourseIndex]);
      }
    }
  }, [course, trackData.courses]);

  const fetchTrackData = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem("token");
      
      if (!token) {
        throw new Error("Authentication required");
      }
      
      // Get user ID from token or localStorage
      const userId = localStorage.getItem("userId") || getUserIdFromToken(token);
      
      if (!userId) {
        throw new Error("Invalid authentication token");
      }
      
      // Store userId in localStorage if not already there
      if (!localStorage.getItem("userId")) {
        localStorage.setItem("userId", userId);
      }

      // Fetch track data
      const trackResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}tracks/${id}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      if (!trackResponse.data) {
        throw new Error("Track not found");
      }
      
      // Sort courses by order property
      const sortedCourses = [...trackResponse.data.courses].sort((a, b) => a.order - b.order);
      
      setTrackData({
        name: trackResponse.data.name || "Track",
        description: trackResponse.data.description || "",
        courses: sortedCourses || []
      });
      
      // Update user data with track info
      setUserData({
        name: localStorage.getItem("userName") || "",
        cohort: localStorage.getItem("userCohort") || "",
        track: trackResponse.data.name || "",
        trackId: id,
        studentId: userId,
      });
      
      // If course is specified in URL, load that course
      if (course && sortedCourses.length > 0) {
        const selectedCourseIndex = sortedCourses.findIndex(c => c.course_id === course);
        if (selectedCourseIndex !== -1) {
          setCurrentCourseIndex(selectedCourseIndex);
          setCourseData(sortedCourses[selectedCourseIndex]);
        } else {
          // If specified course not found, load the first course
          setCurrentCourseIndex(0);
          setCourseData(sortedCourses[0]);
          // Update URL with the course ID
          router.replace(`/tracks/${id}?course=${sortedCourses[0].course_id}`, undefined, { shallow: true });
        }
      } else if (sortedCourses.length > 0) {
        // If no course specified in URL, load the first course
        setCurrentCourseIndex(0);
        setCourseData(sortedCourses[0]);
        // Update URL with the course ID
        router.replace(`/tracks/${id}?course=${sortedCourses[0].course_id}`, undefined, { shallow: true });
      }
      
      setLoading(false);
    } catch (err) {
      console.error("Error fetching track data:", err);
      
      if (err.response && err.response.status === 401) {
        // Token expired
        localStorage.removeItem("token");
        localStorage.removeItem("refreshToken");
        router.push("/login");
        return;
      }
      
      setError(err.message || "Failed to load track data");
      setLoading(false);
    }
  };
  
  // Helper function for safe rendering
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

  // Enhanced function to extract YouTube video ID from various URL formats
  const extractYouTubeId = (url) => {
    if (!url) return null;
    
    // Handle different YouTube URL formats
    const patterns = [
      // Standard watch URLs
      /(?:youtube\.com\/(?:watch\?(?:.*&)?v=|embed\/|v\/)|youtu\.be\/)([\w-]{11})/i,
      // Short URLs
      /(?:youtu\.be\/)([\w-]{11})/i,
      // Embed URLs
      /(?:youtube\.com\/embed\/)([\w-]{11})/i,
      // YouTube Shorts
      /(?:youtube\.com\/shorts\/)([\w-]{11})/i
    ];
    
    for (const pattern of patterns) {
      const match = url.match(pattern);
      if (match && match[1]) {
        return match[1];
      }
    }
    
    return null;
  };

  // Function to handle iframe load errors
  const handleVideoError = () => {
    setVideoError(true);
  };

  // Function to handle course pagination
  const navigateToCourse = (direction) => {
    const newIndex = direction === 'next' 
      ? currentCourseIndex + 1 
      : currentCourseIndex - 1;
      
    if (newIndex < 0 || newIndex >= trackData.courses.length) {
      return; // Don't go beyond the available courses
    }
    
    const targetCourse = trackData.courses[newIndex];
    router.push(`/tracks/${id}?course=${targetCourse.course_id}`, undefined, { shallow: true });
  };

  // Function to check if the URL is likely a Google Drive link
  const isGoogleDriveLink = (url) => {
    return url && url.includes('drive.google.com');
  };

  // Function to check if the URL is a YouTube link
  const isYouTubeLink = (url) => {
    return extractYouTubeId(url) !== null;
  };

  // Function to render the access link appropriately based on type
  const renderAccessLink = (link) => {
    if (!link) return null;
    
    // Check if it's a YouTube video
    const youtubeId = extractYouTubeId(link);
    if (youtubeId) {
      return (
        <div className="mt-24">
          <h3 className="text-base font-semibold text-N500 mb-16">Course Video</h3>
          <div className="aspect-video mb-16">
            <iframe
              className="w-full h-full rounded-lg"
              src={`https://www.youtube.com/embed/${youtubeId}`}
              title={courseData.title}
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowFullScreen
              onError={handleVideoError}
            ></iframe>
          </div>
          <div className="text-right">
            <a 
              href={link} 
              target="_blank" 
              rel="noopener noreferrer"
              className="text-P300 hover:text-P200 text-sm font-medium"
            >
              Open in YouTube
            </a>
          </div>
        </div>
      );
    }
    
    // For Google Drive links or other links
    return (
      <div className="mt-24">
        <h3 className="text-base font-semibold text-N500 mb-8">Course Materials</h3>
        <div className="bg-N50 p-16 rounded-lg">
          <div className="flex items-center">
            <div className="w-40 h-40 rounded-full bg-P300 text-N00 flex items-center justify-center mr-16">
              {isGoogleDriveLink(link) ? (
                <svg xmlns="http://www.w3.org/2000/svg" className="h-24 w-24" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 10v6m0 0l-3-3m3 3l3-3M3 17V7a2 2 0 012-2h6l2 2h6a2 2 0 012 2v8a2 2 0 01-2 2H5a2 2 0 01-2-2z" />
                </svg>
              ) : (
                <svg xmlns="http://www.w3.org/2000/svg" className="h-24 w-24" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                </svg>
              )}
            </div>
            <div className="flex-1">
              <p className="text-sm font-medium text-N500">Course Access Link</p>
              <p className="text-xs text-N200 break-all">{link}</p>
            </div>
            <a 
              href={link} 
              target="_blank" 
              rel="noopener noreferrer"
              className="ml-16 bg-P300 text-N00 py-8 px-16 rounded-lg hover:bg-P200 transition text-sm font-medium"
            >
              Open
            </a>
          </div>
        </div>
      </div>
    );
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-N50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-t-4 border-b-4 border-P300 mx-auto"></div>
          <p className="mt-16 font-medium text-N300">Loading course content...</p>
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
          <h3 className="text-xl font-bold text-N500 mb-8">Error Loading Course</h3>
          <p className="text-N300 mb-16">{error}</p>
          <Link href="/dashboard">
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
        <title>{courseData.name} | {trackData.name} | Milsat Aspirant Program</title>
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
              
              <div className="flex items-center">
                <div className="mr-24 text-right">
                  <p className="text-xs text-N200">Student ID</p>
                  <p className="text-sm font-medium text-N500">{userData.studentId}</p>
                </div>
                <Link href="/dashboard" className="text-sm text-P300 hover:text-P200 font-medium">
                  Back to Dashboard
                </Link>
              </div>
            </div>
          </div>
        </header>
        
        {/* Main Content */}
        <main className="container mx-auto px-16 lg:px-48 py-32">
          {/* Track Header */}
          <div className="bg-P300 text-N00 rounded-lg p-24 mb-32 shadow-card">
            <h1 className="text-xl font-bold mb-8">{trackData.name}</h1>
            <p className="text-sm opacity-90">{trackData.description}</p>
          </div>
          
          {/* Course Counter */}
          <div className="flex justify-between items-center mb-24">
            <h2 className="text-base font-bold text-N500">
              Course {currentCourseIndex + 1} of {trackData.courses.length}
            </h2>
            
            {/* Pagination Controls */}
            <div className="flex gap-8">
              <button
                onClick={() => navigateToCourse('prev')}
                disabled={currentCourseIndex === 0}
                className={`py-8 px-16 rounded-lg text-sm font-medium transition ${
                  currentCourseIndex === 0
                    ? "bg-N100 text-N200 cursor-not-allowed"
                    : "bg-P300 text-N00 hover:bg-P200"
                }`}
              >
                Previous
              </button>
              <button
                onClick={() => navigateToCourse('next')}
                disabled={currentCourseIndex === trackData.courses.length - 1}
                className={`py-8 px-16 rounded-lg text-sm font-medium transition ${
                  currentCourseIndex === trackData.courses.length - 1
                    ? "bg-N100 text-N200 cursor-not-allowed"
                    : "bg-P300 text-N00 hover:bg-P200"
                }`}
              >
                Next
              </button>
            </div>
          </div>
          
          {/* Course Content */}
          <div className="bg-N00 rounded-lg shadow-xl mb-32 p-24">
            {courseData ? (
              <>
                <h2 className="text-lg font-bold text-N500 mb-8">{courseData.name}</h2>
                
                {/* Course Description */}
                <div className="mb-16">
                  <h3 className="text-base font-semibold text-N500 mb-8">Description</h3>
                  <p className="text-sm text-N300">{courseData.description}</p>
                </div>
                
                {/* Course Requirements */}
                {courseData.requirements && (
                  <div className="mb-16">
                    <h3 className="text-base font-semibold text-N500 mb-8">Requirements</h3>
                    <p className="text-sm text-N300">{courseData.requirements}</p>
                  </div>
                )}
                
                {/* Course Access Link */}
                {renderAccessLink(courseData.access_link)}
              </>
            ) : (
              <div className="flex items-center justify-center h-64">
                <p className="text-N200">No course data available</p>
              </div>
            )}
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

export default TrackDetail;