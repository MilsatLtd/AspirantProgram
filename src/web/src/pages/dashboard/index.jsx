// import { useState, useEffect } from "react";
// import Image from "next/image";
// import Link from "next/link";
// import Head from "next/head";
// import axios from "axios";
// import { useRouter } from "next/router";
// import Logo from "../../Assets/logo.svg";

// const StudentDashboard = () => {
//   const router = useRouter();
//   const [loading, setLoading] = useState(true);
//   const [error, setError] = useState("");
//   const [userData, setUserData] = useState({
//     name: "",
//     cohort: "",
//     track: "",
//     trackId: "",
//     studentId: "",
//   });
//   const [courses, setCourses] = useState([]);
//   const [mentor, setMentor] = useState({
//     name: "",
//     bio: "",
//     whatsappLink: "",
//     avatar: "",
//   });
//   const [activeTab, setActiveTab] = useState("courses");

//   const ensureSafeRender = (value) => {
//     if (value === null || value === undefined) {
//       return '';
//     }
//     if (typeof value === 'object') {
//       if (value.cohort_id && value.name && value.cohort_duration) {
//         return value.name; 
//       }
//       return JSON.stringify(value); 
//     }
//     return value;
//   };

//   // Add useEffect to trigger data fetching when component mounts
//   useEffect(() => {
//     const token = localStorage.getItem("token");
    
//     if (!token) {
//       router.push("/login");
//       return;
//     }
    
//     fetchStudentData();
//   }, []);

//   const fetchStudentData = async () => {
//     try {
//       setLoading(true);
//       const token = localStorage.getItem("token");
      
//       if (!token) {
//         throw new Error("Authentication required");
//       }
      
//       // Get user ID from token
//       const userId = getUserIdFromToken(token);
//       console.log("User ID extracted from token:", userId);
      
//       if (!userId) {
//         throw new Error("Invalid authentication token");
//       }
      
//       try {
// <<<<<<< HEAD
// =======
//         setLoading(true);
//         const token = localStorage.getItem("token");
        
//         if (!token) {
//           throw new Error("Authentication required");
//         }
        
//         // Get user ID from token (assuming JWT with user_id in payload)
//         // In a real implementation, you would decode the token or get the user ID from somewhere
//         const userId = getUserIdFromToken(token);
        
// >>>>>>> 811d42c (search bar added to the apply form)
//         // Get the latest track of the student
//         const latestTrackResponse = await axios.get(
//           `${process.env.NEXT_PUBLIC_API_ROUTE}students/recent/${userId}`,
//           {
//             headers: { Authorization: `Bearer ${token}` }
//           }
//         );
        
// <<<<<<< HEAD
//         console.log("Latest track response:", latestTrackResponse.data);
        
//         // Check if we have a valid track_id
//         if (!latestTrackResponse.data || !latestTrackResponse.data.track_id) {
//           console.log("No track_id in recent response, trying alternative approach");
          
//           const studentResponse = await axios.get(
//             `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}`,
//             {
//               headers: { Authorization: `Bearer ${token}` }
//             }
//           );
          
//           console.log("Student response:", studentResponse.data);
          
//           // Check if the response includes any track information we can use
//           if (studentResponse.data && studentResponse.data.track_id) {
//             const trackId = studentResponse.data.track_id;
//             console.log("Found track_id in student data:", trackId);
//             // Continue with this track ID
//             await completeDataFetch(userId, trackId, token);
//           } else {
//             console.log("No track_id found in any response");
            
//             // FALLBACK: Instead of erroring, set default data
//             setUserData({
//               name: studentResponse.data?.full_name || "Student",
//               // Handle cohort as an object or string
//               cohort: typeof studentResponse.data?.cohort === 'object' 
//                 ? studentResponse.data?.cohort.name 
//                 : (studentResponse.data?.cohort || "Current Cohort"),
//               track: "Unassigned",
//               trackId: "default",
//               studentId: userId,
//             });
            
//             setCourses([]);
            
//             if (studentResponse.data?.mentor) {
//               // Handle mentor data safely
//               const mentorData = studentResponse.data.mentor;
//               setMentor({
//                 name: typeof mentorData === 'object' ? mentorData.full_name || "Mentor" : mentorData,
//                 bio: typeof mentorData === 'object' ? mentorData.bio || "Mentor information" : "Mentor information",
//                 whatsappLink: "#",
//                 avatar: studentResponse.data.profile_picture || "/api/placeholder/80/80",
//               });
//             }
            
//             setLoading(false);
// =======
//         const trackId = latestTrackResponse.data.track_id;
        
//         // Fetch student data with the latest track
//         const userResponse = await axios.get(
//           `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}/${trackId}`,
//           {
//             headers: { Authorization: `Bearer ${token}` }
//           }
//         );
        
//         // Fetch courses for the student's track
//         const coursesResponse = await axios.get(
//           `${process.env.NEXT_PUBLIC_API_ROUTE}students/courses/${userId}/${trackId}`,
//           {
//             headers: { Authorization: `Bearer ${token}` }
// >>>>>>> 811d42c (search bar added to the apply form)
//           }
//         } else {
//           // We have a valid track ID, continue normally
//           const trackId = latestTrackResponse.data.track_id;
//           console.log("Using track_id from recent response:", trackId);
//           await completeDataFetch(userId, trackId, token);
//         }
//       } catch (trackError) {
//         console.error("Error fetching track:", trackError);
        
//         // FALLBACK: Instead of showing error, show empty dashboard
//         setUserData({
// <<<<<<< HEAD
//           name: "Student",
//           cohort: "Current Cohort",
//           track: "Unassigned",
//           trackId: "default",
//           studentId: userId,
//         });
        
//         setCourses([]);
// =======
//           name: userResponse.data.full_name,
//           cohort: userResponse.data.cohort,
//           track: userResponse.data.track,
//           trackId: trackId,
//           studentId: userId,
//         });
        
//         // The courses are nested in a track object based on the API docs
//         setCourses(coursesResponse.data.courses || []);
        
//         // For mentor data, we would need additional API call or data might be included in student response
//         // This depends on how your API is structured
//         if (userResponse.data.mentor) {
//           setMentor({
//             name: userResponse.data.mentor,
//             bio: "Mentor information", // This would need to come from API
//             whatsappLink: "#", // This would need to come from API
//             avatar: userResponse.data.profile_picture || "/api/placeholder/80/80",
//           });
//         }
        
//       } catch (err) {
//         setError(err.message || "Failed to load student data");
//         console.error(err);
//       } finally {
// >>>>>>> 811d42c (search bar added to the apply form)
//         setLoading(false);
//       }
//     } catch (err) {
//       console.error("Overall error:", err);
//       setError(err.message || "Failed to load student data");
//       setLoading(false);
      
//       // If authentication error, redirect to login
//       if (err.message === "Authentication required" || err.message === "Invalid authentication token") {
//         router.push("/login");
//       }
//     }
//   };
  
//   const completeDataFetch = async (userId, trackId, token) => {
//     try {
//       // Fetch student data with the track
//       const userResponse = await axios.get(
//         `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}/${trackId}`,
//         {
//           headers: { Authorization: `Bearer ${token}` }
//         }
//       );
      
//       // Fetch courses for the student's track
//       const coursesResponse = await axios.get(
//         `${process.env.NEXT_PUBLIC_API_ROUTE}students/courses/${userId}/${trackId}`,
//         {
//           headers: { Authorization: `Bearer ${token}` }
//         }
//       );
      
//       setUserData({
//         name: userResponse.data.full_name || "Student",
//         // Handle cohort as an object or string
//         cohort: typeof userResponse.data.cohort === 'object' 
//           ? userResponse.data.cohort.name 
//           : (userResponse.data.cohort || "Current Cohort"),
//         track: userResponse.data.track || "General",
//         trackId: trackId,
//         studentId: userId,
//       });
      
//       setCourses(coursesResponse.data.courses || []);
      
//       // For mentor data 
//       if (userResponse.data.mentor) {
//         const mentorData = userResponse.data.mentor;
//         // Check if mentor is an object or a string
//         if (typeof mentorData === 'object' && mentorData !== null) {
//           setMentor({
//             name: mentorData.full_name || "Mentor",
//             bio: mentorData.bio || "Mentor information",
//             whatsappLink: "#",
//             avatar: mentorData.profile_picture || "/api/placeholder/80/80",
//           });
//         } else {
//           // If it's a string or other primitive value
//           setMentor({
//             name: String(mentorData),
//             bio: "Mentor information",
//             whatsappLink: "#", 
//             avatar: "/api/placeholder/80/80",
//           });
//         }
//       }
//     } catch (error) {
//       console.error("Error completing data fetch:", error);
//       setError("Error loading data with track information");
//     } finally {
//       setLoading(false);
//     }
//   };
  
//   // Helper function to extract user ID from token
//   const getUserIdFromToken = (token) => {
//     try {
//       // JWT tokens are in format: header.payload.signature
//       const parts = token.split('.');
      
//       if (parts.length !== 3) {
//         console.error("Invalid token format");
//         return null;
//       }
      
//       const payload = parts[1];
      
//       // Base64 decode the payload
//       // Note: JWT uses base64url encoding, so we need to replace some characters
//       const base64 = payload.replace(/-/g, '+').replace(/_/g, '/');
//       const decodedPayload = JSON.parse(atob(base64));
      
//       return decodedPayload.user_id;
//     } catch (error) {
//       console.error("Error decoding token:", error);
//       return null;
//     }
//   };

//   // Helper function to extract user ID from token
//   // This is a placeholder - implement according to your token structure
//   const getUserIdFromToken = (token) => {
//     // In a real application, decode JWT token or get user ID from appropriate storage
//     // For example, if using JWT, you might use jwt_decode library
//     return localStorage.getItem("userId") || "current-user-id";
//   };

//   if (loading) {
//     return (
//       <div className="flex items-center justify-center min-h-screen bg-N50">
//         <div className="text-center">
//           <div className="animate-spin rounded-full h-32 w-32 border-t-4 border-b-4 border-P300 mx-auto"></div>
//           <p className="mt-16 font-medium text-N300">Loading student dashboard...</p>
//         </div>
//       </div>
//     );
//   }

//   if (error) {
//     return (
//       <div className="flex items-center justify-center min-h-screen bg-N50">
//         <div className="bg-N00 p-24 rounded-lg shadow-xl max-w-md w-full">
//           <div className="text-center text-R300 mb-16">
//             <svg xmlns="http://www.w3.org/2000/svg" className="h-32 w-32 mx-auto" fill="none" viewBox="0 0 24 24" stroke="currentColor">
//               <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
//             </svg>
//           </div>
//           <h3 className="text-xl font-bold text-N500 mb-8">Error Loading Dashboard</h3>
//           <p className="text-N300 mb-16">{error}</p>
//           <Link href="/login">
//             <button className="w-full bg-P300 text-N00 py-12 px-24 rounded-lg hover:bg-P200 transition duration-300 font-semibold">
//               Back to Login
//             </button>
//           </Link>
//         </div>
//       </div>
//     );
//   }

//   return (
//     <>
//       <Head>
//         <title>Student Dashboard | Milsat Aspirant Program</title>
//       </Head>
      
//       <div className="min-h-screen bg-N50">
//         {/* Header/Navigation */}
//         <header className="bg-N00 shadow-xl">
//           <div className="container mx-auto px-16 lg:px-48">
//             <div className="flex items-center justify-between py-16">
//               <Link href="/dashboard">
//                 <div className="inline-block">
//                   <Image src={Logo} alt="MAP-logo" className="h-auto w-auto" />
//                 </div>
//               </Link>
              
//               <div className="flex items-center space-x-16">
//                 <div className="text-right mr-16">
//                   <p className="text-sm font-medium text-N300">{userData.name}</p>
//                   <p className="text-xs text-N200">{userData.track} Track</p>
//                 </div>
//                 <button className="bg-P300 text-N00 rounded-full w-40 h-40 flex items-center justify-center">
//                   <span className="font-semibold">{userData.name ? userData.name.charAt(0) : ''}</span>
//                 </button>
//               </div>
//             </div>
//           </div>
//         </header>
        
//         {/* Main Content */}
//         <main className="container mx-auto px-16 lg:px-48 py-32">
//           {/* Cohort Information */}
//           <div className="bg-P300 text-N00 rounded-lg p-24 mb-32 shadow-card">
//             <div className="flex flex-col md:flex-row md:items-center justify-between">
//               <div>
//                 <h1 className="text-xl font-bold mb-8">Welcome to {ensureSafeRender(userData.cohort)}</h1>
//                 <p className="text-sm opacity-90">Track: {userData.track}</p>
//               </div>
//               <div className="mt-16 md:mt-0">
//                 <button 
//                   onClick={() => setActiveTab("mentor")}
//                   className="bg-N00 text-P300 py-8 px-16 rounded-lg font-medium text-sm hover:bg-N50 transition duration-300"
//                 >
//                   View Assigned Mentor
//                 </button>
//               </div>
//             </div>
//           </div>
          
//           {/* Tabs */}
//           <div className="bg-N00 rounded-lg shadow-xl mb-32">
//             <div className="flex border-b border-N50">
//               <button 
//                 onClick={() => setActiveTab("courses")}
//                 className={`flex-1 py-16 text-center font-medium text-sm ${
//                   activeTab === "courses" 
//                     ? "text-P300 border-b-2 border-P300" 
//                     : "text-N300 hover:text-P200"
//                 }`}
//               >
//                 My Courses
//               </button>
//               <button 
//                 onClick={() => setActiveTab("mentor")}
//                 className={`flex-1 py-16 text-center font-medium text-sm ${
//                   activeTab === "mentor" 
//                     ? "text-P300 border-b-2 border-P300" 
//                     : "text-N300 hover:text-P200"
//                 }`}
//               >
//                 Assigned Mentor
//               </button>
//             </div>
            
//             {/* Tab Content */}
//             <div className="p-24">
//               {activeTab === "courses" && (
//                 <div>
//                   <h2 className="text-lg font-bold text-N500 mb-24">Available Courses</h2>
                  
//                   {courses.length === 0 ? (
//                     <div className="text-center py-48">
//                       <p className="text-N200">No courses are currently available for your track.</p>
//                     </div>
//                   ) : (
//                     <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-24">
//                       {courses.map((course, index) => (
//                         <div key={index} className="bg-N50 rounded-lg overflow-hidden shadow-lg hover:shadow-xl transition duration-300">
//                           <div className="aspect-video bg-N100 relative">
//                             {course.thumbnail ? (
//                               <Image 
//                                 src={course.thumbnail} 
//                                 alt={course.name}
//                                 layout="fill"
//                                 objectFit="cover"
//                               />
//                             ) : (
//                               <div className="w-full h-full flex items-center justify-center bg-P50">
//                                 <span className="text-P300 font-medium">{course.name.charAt(0)}</span>
//                               </div>
//                             )}
//                           </div>
                          
//                           <div className="p-16">
//                             <h3 className="text-base font-semibold text-N500 mb-8">{course.name}</h3>
//                             <p className="text-sm text-N200 mb-16">{course.description}</p>
                            
//                             <Link href={`/courses/${course.course_id}`}>
//                               <button className="w-full bg-P300 text-N00 py-8 px-16 rounded-lg text-sm font-medium hover:bg-P200 transition duration-300">
//                                 View Course
//                               </button>
//                             </Link>
//                           </div>
//                         </div>
//                       ))}
//                     </div>
//                   )}
//                 </div>
//               )}
              
//               {activeTab === "mentor" && (
//                 <div>
//                   <h2 className="text-lg font-bold text-N500 mb-24">Assigned Mentor</h2>
                  
//                   <div className="bg-N50 rounded-lg p-24">
//                     <div className="flex flex-col md:flex-row items-start gap-24">
//                       <div className="w-80 h-80 rounded-full overflow-hidden bg-P50 flex-shrink-0">
//                         {mentor.avatar ? (
//                           <Image 
//                             src={mentor.avatar} 
//                             alt={mentor.name}
//                             width={80}
//                             height={80}
//                             className="w-full h-full object-cover"
//                           />
//                         ) : (
//                           <div className="w-full h-full flex items-center justify-center bg-P300 text-N00">
//                             <span className="font-semibold text-lg">{mentor.name.charAt(0)}</span>
//                           </div>
//                         )}
//                       </div>
                      
//                       <div className="flex-1">
//                         <h3 className="text-xl font-bold text-N500 mb-8">{mentor.name}</h3>
//                         <p className="text-sm text-N300 mb-16">{mentor.bio}</p>
                        
//                         {mentor.whatsappLink && (
//                           <a 
//                             href={mentor.whatsappLink} 
//                             target="_blank" 
//                             rel="noopener noreferrer"
//                             className="inline-flex items-center text-sm font-medium text-P300 hover:text-P200 transition"
//                           >
//                             <svg xmlns="http://www.w3.org/2000/svg" className="h-16 w-16 mr-8" fill="currentColor" viewBox="0 0 24 24">
//                               <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
//                             </svg>
//                             Join WhatsApp Group
//                           </a>
//                         )}
//                       </div>
//                     </div>
//                   </div>
//                 </div>
//               )}
//             </div>
//           </div>
//         </main>
        
//         {/* Footer */}
//         <footer className="bg-N500 text-N00 py-32">
//           <div className="container mx-auto px-16 lg:px-48">
//             <div className="flex flex-col md:flex-row justify-between items-center">
//               <div className="mb-24 md:mb-0">
//                 <Image src={Logo} alt="MAP-logo" className="h-auto w-auto" />
//                 <p className="text-xs text-N100 mt-8">© 2025 Milsat Aspirant Program. All rights reserved.</p>
//               </div>
              
//               <div className="flex space-x-16">
//                 <Link href="/dashboard" className="text-sm text-N100 hover:text-N00">Dashboard</Link>
//                 <Link href="/courses" className="text-sm text-N100 hover:text-N00">Courses</Link>
//                 <Link href="/support" className="text-sm text-N100 hover:text-N00">Support</Link>
//               </div>
//             </div>
//           </div>
//         </footer>
//       </div>
//     </>
//   );
// };

// export default StudentDashboard;