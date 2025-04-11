import { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import { useRouter } from "next/router";
import Head from "next/head";
import axios from "axios";
import Logo from "../../Assets/logo.svg";

const CourseDetail = () => {
  const router = useRouter();
  const { id } = router.query;
  
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [userData, setUserData] = useState({
    name: "",
    cohort: "",
    track: "",
    trackId: "",
    studentId: "",
  });
  const [course, setCourse] = useState({
    title: "",
    description: "",
    lessons: [],
    resources: []
  });
  const [activeLesson, setActiveLesson] = useState(null);
  const [videoError, setVideoError] = useState(false);

  useEffect(() => {
    if (id) {
      const token = localStorage.getItem("token");
      
      if (!token) {
        router.push("/login");
        return;
      }
      
      fetchCourseData();
    }
  }, [id, router]);

  const fetchCourseData = async () => {
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
      
      try {
        // Step 1: Try to get the most recent track
        const latestTrackResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}students/recent/${userId}`,
          { headers: { Authorization: `Bearer ${token}` } }
        );
        
        let trackId;
        
        // Check if we have a valid track from the recent endpoint
        if (latestTrackResponse.data && latestTrackResponse.data.track) {
          trackId = latestTrackResponse.data.track;
        } else {
          // Step 2: If no recent track, get student info to find any track_id
          const studentResponse = await axios.get(
            `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}`,
            { headers: { Authorization: `Bearer ${token}` } }
          );
          
          // Check if the response includes track information we can use
          if (studentResponse.data && studentResponse.data.track && studentResponse.data.track.track_id) {
            trackId = studentResponse.data.track.track_id;
          } else {
            throw new Error("Could not determine your track. Please contact support.");
          }
        }
        
        // Step 3: We have a track ID, fetch detailed data
        await fetchUserAndCourseData(userId, trackId, token);
        
      } catch (error) {
        console.error("Error in data fetching flow:", error);
        setError("Could not retrieve your course information. Please return to dashboard and try again.");
        setLoading(false);
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
      
      setError(err.message || "Failed to load course data");
      setLoading(false);
    }
  };
  
  const fetchUserAndCourseData = async (userId, trackId, token) => {
    try {
      // Fetch student data with the track
      const userResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}/${trackId}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      // Update user data
      setUserData({
        name: userResponse.data.full_name || "",
        cohort: ensureSafeRender(userResponse.data.cohort) || "",
        track: userResponse.data.track ? ensureSafeRender(userResponse.data.track) : "",
        trackId: trackId,
        studentId: userId,
      });
      
      // Fetch the specific course details
      const courseResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}courses/${id}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      // Process lessons to ensure video URLs are ready
      const processedLessons = courseResponse.data.lessons?.map(lesson => ({
        ...lesson,
        youtube_id: lesson.video_url ? extractYouTubeId(lesson.video_url) : null
      })) || [];
      
      setCourse({
        title: courseResponse.data.name || "Course",
        description: courseResponse.data.description || "",
        lessons: processedLessons,
        resources: courseResponse.data.resources || []
      });
      
      if (processedLessons.length > 0) {
        setActiveLesson(processedLessons[0]);
      }
    } catch (error) {
      console.error("Error fetching course details:", error);
      setError("Error loading course details. This course may not be available to you.");
    } finally {
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

  // Function to reset video error when changing lessons
  const handleLessonChange = (lesson) => {
    setVideoError(false);
    setActiveLesson(lesson);
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
        <title>{course.title} | Milsat Aspirant Program</title>
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
                <Link href="/dashboard" className="text-sm text-P300 hover:text-P200 font-medium">
                  Back to Dashboard
                </Link>
              </div>
            </div>
          </div>
        </header>
        
        {/* Main Content */}
        <main className="container mx-auto px-16 lg:px-48 py-32">
          {/* Course Header */}
          <div className="bg-P300 text-N00 rounded-lg p-24 mb-32 shadow-card">
            <h1 className="text-xl font-bold mb-8">{course.title}</h1>
            <p className="text-sm opacity-90">{course.description}</p>
          </div>
          
          {/* Course Content */}
          <div className="bg-N00 rounded-lg shadow-xl mb-32">
            <div className="flex flex-col md:flex-row">
              {/* Sidebar - Lesson List */}
              <div className="md:w-1/3 border-r border-N50">
                <div className="p-16">
                  <h2 className="text-base font-bold text-N500 mb-16">Course Lessons</h2>
                  
                  {course.lessons && course.lessons.length === 0 ? (
                    <p className="text-sm text-N200">No lessons available for this course.</p>
                  ) : (
                    <div className="space-y-8">
                      {course.lessons.map((lesson, index) => (
                        <button
                          key={index}
                          onClick={() => handleLessonChange(lesson)}
                          className={`w-full text-left p-12 rounded-lg text-sm transition ${
                            activeLesson && activeLesson.id === lesson.id
                              ? "bg-P50 text-P300 font-medium"
                              : "hover:bg-N50 text-N300"
                          }`}
                        >
                          <div className="flex items-center">
                            <span className="w-24 h-24 rounded-full bg-N100 flex items-center justify-center text-xs text-N00 mr-12">
                              {index + 1}
                            </span>
                            <span className="line-clamp-2">{lesson.title}</span>
                            {lesson.youtube_id && (
                              <span className="ml-8 text-P300">
                                <svg xmlns="http://www.w3.org/2000/svg" className="h-12 w-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                </svg>
                              </span>
                            )}
                          </div>
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              </div>
              
              {/* Main Content - Video Player and Resources */}
              <div className="md:w-2/3 p-24">
                {activeLesson ? (
                  <>
                    <h2 className="text-lg font-bold text-N500 mb-16">{activeLesson.title}</h2>
                    
                    {/* Video Player with improved handling */}
                    {activeLesson.video_url ? (
                      <div className="aspect-video mb-24">
                        {activeLesson.youtube_id && !videoError ? (
                          <iframe
                            className="w-full h-full rounded-lg"
                            src={`https://www.youtube.com/embed/${activeLesson.youtube_id}`}
                            title={activeLesson.title}
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                            allowFullScreen
                            onError={handleVideoError}
                          ></iframe>
                        ) : (
                          <div className="aspect-video bg-N100 rounded-lg flex items-center justify-center">
                            <div className="text-center p-16">
                              <svg xmlns="http://www.w3.org/2000/svg" className="h-32 w-32 mx-auto text-N200" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                              </svg>
                              <p className="mt-8 text-N200">
                                {videoError ? "Error loading video. Please try again later." : "Unable to display video"}
                              </p>
                              <a 
                                href={activeLesson.video_url} 
                                target="_blank" 
                                rel="noopener noreferrer"
                                className="mt-8 inline-block text-P300 hover:text-P200 text-sm font-medium"
                              >
                                Open video in new tab
                              </a>
                            </div>
                          </div>
                        )}
                      </div>
                    ) : (
                      <div className="aspect-video bg-N100 rounded-lg mb-24 flex items-center justify-center">
                        <p className="text-N200">No video available for this lesson</p>
                      </div>
                    )}
                    
                    {/* Lesson Description */}
                    <div className="mb-32">
                      <h3 className="text-base font-semibold text-N500 mb-8">Description</h3>
                      <p className="text-sm text-N300">{activeLesson.description}</p>
                    </div>
                    
                    {/* Resources Section */}
                    {activeLesson.resources && activeLesson.resources.length > 0 && (
                      <div>
                        <h3 className="text-base font-semibold text-N500 mb-16">Additional Resources</h3>
                        <div className="space-y-8">
                          {activeLesson.resources.map((resource, index) => (
                            <a
                              key={index}
                              href={resource.url}
                              target="_blank"
                              rel="noopener noreferrer"
                              className="flex items-center p-12 rounded-lg bg-N50 hover:bg-P50 transition group"
                            >
                              <div className="w-32 h-32 rounded-full bg-P300 text-N00 flex items-center justify-center mr-12">
                                {/* Display YouTube icon for video resources */}
                                {resource.type?.toLowerCase().includes('video') || extractYouTubeId(resource.url) ? (
                                  <svg xmlns="http://www.w3.org/2000/svg" className="h-16 w-16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                                  </svg>
                                ) : (
                                  <svg xmlns="http://www.w3.org/2000/svg" className="h-16 w-16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                  </svg>
                                )}
                              </div>
                              <div>
                                <p className="text-sm font-medium text-N500 group-hover:text-P300 transition">{resource.title}</p>
                                <p className="text-xs text-N200">{resource.type}</p>
                              </div>
                            </a>
                          ))}
                        </div>
                      </div>
                    )}
                  </>
                ) : (
                  <div className="flex items-center justify-center h-full">
                    <div className="text-center">
                      <svg xmlns="http://www.w3.org/2000/svg" className="h-48 w-48 mx-auto text-N100" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                      <p className="mt-16 text-N200">Select a lesson to view its content</p>
                    </div>
                  </div>
                )}
              </div>
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

export default CourseDetail;