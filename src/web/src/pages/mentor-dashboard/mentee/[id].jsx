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
    profile_picture: ""
  });
  
  const [mentorData, setMentorData] = useState({
    name: "",
    email: "",
    track: "",
    cohort: "",
    profilePicture: ""
  });
  
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
          profile_picture: menteeInfo.profile_picture || ""
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
      }
    } catch (error) {
      console.error("Error fetching mentor data:", error);
    }
  };
  
  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-N50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-t-4 border-b-4 border-P300 mx-auto"></div>
          <p className="mt-20 font-medium text-N300">Loading mentee details...</p>
        </div>
      </div>
    );
  }
  
  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-N50">
        <div className="bg-N00 p-24 rounded-lg shadow-xl max-w-md w-full">
          <div className="text-center text-R300 mb-16">
            <svg xmlns="http://www.w3.org/2000/svg" className="h-12 w-12 mx-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <h3 className="text-xl font-semibold text-N500 mb-8">Error</h3>
          <p className="text-N300 mb-16">{error}</p>
          <Link href="/mentor-dashboard">
            <button className="w-full bg-P300 text-N00 py-12 px-16 rounded-lg hover:bg-P400 transition duration-300 font-semibold">
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
          <div className="container mx-auto px-24 lg:px-40">
            <div className="flex items-center justify-between py-16">
              <Link href="/mentor-dashboard">
                <div className="inline-block">
                  <Image src={Logo} alt="MAP-logo" width={120} height={40} />
                </div>
              </Link>
              
              <div className="flex items-center space-x-12">
                <div className="text-right mr-12">
                  <p className="text-sm font-medium text-N500">{mentorData.name}</p>
                  <p className="text-xs text-N200">Mentor - {mentorData.track}</p>
                </div>
                <div className="bg-P300 text-N00 rounded-full w-40 h-40 flex items-center justify-center shadow-card">
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
        <main className="container mx-auto px-24 lg:px-40 py-40">
          {/* Back button */}
          <div className="mb-20">
            <button 
              onClick={() => router.back()}
              className="flex items-center text-P300 hover:text-P400 font-medium"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 mr-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
              </svg>
              Back to Dashboard
            </button>
          </div>
          
          {/* Mentee Profile Card */}
          <div className="bg-N00 rounded-lg shadow-card overflow-hidden mb-32">
            <div className="bg-gradient-to-r from-P300 to-P200 p-16 text-N00">
              <h1 className="text-xl font-bold">Mentee Profile</h1>
            </div>
            
            <div className="p-32">
              <div className="flex flex-col md:flex-row gap-32">
                {/* Profile Image */}
                <div className="flex-shrink-0">
                  <div className="w-96 h-96 rounded-full overflow-hidden bg-N50 border-4 border-N00 shadow-card">
                    {menteeData.profile_picture ? (
                      <img 
                        src={menteeData.profile_picture}
                        alt={menteeData.full_name}
                        className="w-full h-full object-cover"
                      />
                    ) : (
                      <div className="w-full h-full flex items-center justify-center bg-P75 text-P400">
                        <span className="font-bold text-2xl">{menteeData.full_name.charAt(0)}</span>
                      </div>
                    )}
                  </div>
                </div>
                
                {/* Profile Info */}
                <div className="flex-1">
                  <div className="mb-24">
                    <h2 className="text-2xl font-bold text-P400">{menteeData.full_name}</h2>
                    <p className="text-N200">{menteeData.email}</p>
                  </div>
                  
                  <div>
                    <h3 className="font-semibold text-N400 mb-8">Bio</h3>
                    <div className="bg-N50 p-16 rounded-lg">
                      <p className="text-N300">{menteeData.bio}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </main>
        
        {/* Footer */}
        <footer className="bg-P500 text-N00 py-32 mt-auto">
          <div className="container mx-auto px-24 lg:px-40">
            <div className="flex flex-col md:flex-row justify-between items-center">
              <div className="mb-24 md:mb-0">
                <Image src={Logo} alt="MAP-logo" width={120} height={40} />
                <p className="text-xs text-P75 mt-8">© 2025 Milsat Aspirant Program. All rights reserved.</p>
              </div>
              
              <div className="flex space-x-20">
                <Link href="/mentor-dashboard" className="text-sm text-P75 hover:text-N00">Dashboard</Link>
                <Link href="/mentor-resources" className="text-sm text-P75 hover:text-N00">Resources</Link>
                <Link href="/support" className="text-sm text-P75 hover:text-N00">Support</Link>
              </div>
            </div>
          </div>
        </footer>
      </div>
    </>
  );
};

export default MenteeDetail;