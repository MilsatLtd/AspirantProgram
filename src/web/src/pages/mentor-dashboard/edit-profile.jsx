import { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import Head from "next/head";
import axios from "axios";
import { useRouter } from "next/router";
import Logo from "../../Assets/logo.svg";

const EditMentorProfile = () => {
  const router = useRouter();
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");
  const [successMessage, setSuccessMessage] = useState("");
  const [userData, setUserData] = useState({
    name: "",
    email: "",
    bio: "",
    class_url: "",
    profilePicture: "",
    track: "",
    cohort: "",
  });
  const [formData, setFormData] = useState({
    bio: "",
    class_url: "",
    profile_picture: null,
    old_password: "",
    new_password: "",
    new_password_confirm: "",
  });
  const [previewUrl, setPreviewUrl] = useState("");

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
      
      if (!token) {
        throw new Error("Authentication required");
      }
      
      // Get user ID from token or local storage
      const userId = localStorage.getItem("userId") || getUserIdFromToken(token);
      
      if (!userId) {
        throw new Error("Invalid authentication token");
      }

      // Get basic mentor data
      const mentorResponse = await axios.get(
        `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}`,
        { headers: { Authorization: `Bearer ${token}` } }
      );
      
      const mentorData = mentorResponse.data;
      
      // Set user data
      setUserData({
        name: mentorData?.full_name || "",
        email: mentorData?.email || "",
        bio: mentorData?.bio || "",
        class_url: mentorData?.class_url || "",
        profilePicture: mentorData?.profile_picture || "",
        track: ensureSafeRender(mentorData?.track) || "Unassigned",
        cohort: ensureSafeRender(mentorData?.cohort) || "Current Cohort",
      });
      
      // Set form data (only for editable fields)
      setFormData({
        bio: mentorData?.bio || "",
        class_url: mentorData?.class_url || "",
        profile_picture: null,
        old_password: "",
        new_password: "",
        new_password_confirm: "",
      });
      
      // Set profile picture preview if available
      if (mentorData?.profile_picture) {
        setPreviewUrl(mentorData.profile_picture);
      }
      
      setLoading(false);
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
      setLoading(false);
    }
  };
  
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
  
  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };
  
  const handleProfilePictureChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      setFormData(prev => ({
        ...prev,
        profile_picture: file
      }));
      
      // Create a preview URL
      const fileReader = new FileReader();
      fileReader.onload = () => {
        setPreviewUrl(fileReader.result);
      };
      fileReader.readAsDataURL(file);
    }
  };
  
  const validatePasswordChange = () => {
    // Reset error and success messages
    setError("");
    
    if (!formData.old_password) {
      setError("Current password is required to set a new password");
      return false;
    }
    
    if (formData.new_password.length < 8) {
      setError("New password must be at least 8 characters long");
      return false;
    }
    
    if (formData.new_password !== formData.new_password_confirm) {
      setError("New passwords do not match");
      return false;
    }
    
    return true;
  };
  
  const validateClassUrl = (url) => {
    if (!url) return true; // Empty URL is valid (optional field)
    
    try {
      new URL(url);
      return true;
    } catch (e) {
      return false;
    }
  };
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setSuccessMessage("");
    setSubmitting(true);
    
    try {
      const token = localStorage.getItem("token");
      const userId = localStorage.getItem("userId") || getUserIdFromToken(token);
      
      if (!token || !userId) {
        throw new Error("Authentication required");
      }
      
      // Validate class URL if provided
      if (formData.class_url && !validateClassUrl(formData.class_url)) {
        setError("Please enter a valid URL for your class");
        setSubmitting(false);
        return;
      }
      
      let successCount = 0;
      let totalChanges = 0;

      // 1. Update bio and class_url if changed
      if (formData.bio !== userData.bio || formData.class_url !== userData.class_url) {
        totalChanges++;
        await updateUserProfile(userId, token);
        successCount++;
      }
      
      // 2. Update profile picture if changed
      if (formData.profile_picture) {
        totalChanges++;
        await updateProfilePicture(userId, token);
        successCount++;
      }
      
      // 3. Update password if changed
      if (formData.old_password && formData.new_password) {
        totalChanges++;
        if (validatePasswordChange()) {
          await updatePassword(token);
          successCount++;
        }
      }
      
      if (totalChanges === 0) {
        setError("No changes to save");
      } else if (successCount === totalChanges) {
        setSuccessMessage("Profile updated successfully");
        
        // Clear password fields
        setFormData(prev => ({
          ...prev,
          old_password: "",
          new_password: "",
          new_password_confirm: "",
          profile_picture: null
        }));
        
        // Refresh user data
        fetchMentorData();
      }
      
    } catch (err) {
      console.error("Error updating profile:", err);
      
      if (err.response && err.response.status === 401) {
        setError("Current password is incorrect");
      } else if (err.response && err.response.data && err.response.data.message) {
        setError(err.response.data.message);
      } else {
        setError("Failed to update profile. Please try again later.");
      }
    } finally {
      setSubmitting(false);
    }
  };
  
  const updateUserProfile = async (userId, token) => {
    const profileData = { 
      bio: formData.bio,
      class_url: formData.class_url 
    };
    
    await axios.put(
      `${process.env.NEXT_PUBLIC_API_ROUTE}users/update/${userId}`,
      profileData,
      { 
        headers: { 
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json"
        } 
      }
    );
  };
  
  const updateProfilePicture = async (userId, token) => {
    const pictureFormData = new FormData();
    pictureFormData.append("profile_picture", formData.profile_picture);
    
    await axios.put(
      `${process.env.NEXT_PUBLIC_API_ROUTE}users/update/picture/${userId}`,
      pictureFormData,
      { 
        headers: { 
          Authorization: `Bearer ${token}`,
          "Content-Type": "multipart/form-data"
        } 
      }
    );
  };
  
  const updatePassword = async (token) => {
    const passwordData = {
      old_password: formData.old_password,
      new_password: formData.new_password,
      new_password_confirm: formData.new_password_confirm
    };
    
    await axios.put(
      `${process.env.NEXT_PUBLIC_API_ROUTE}auth/password/change`,
      passwordData,
      { 
        headers: { 
          Authorization: `Bearer ${token}`,
          "Content-Type": "application/json"
        } 
      }
    );
  };
  
  const handleCancel = () => {
    router.push("/mentor-dashboard");
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-N50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-t-4 border-b-4 border-P300 mx-auto"></div>
          <p className="mt-16 font-medium text-N300">Loading profile data...</p>
        </div>
      </div>
    );
  }

  return (
    <>
      <Head>
        <title>Edit Profile | Mentor Dashboard</title>
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
          <div className="flex items-center mb-24">
            <button 
              onClick={() => router.push("/mentor-dashboard")}
              className="text-P300 hover:text-P200 font-medium flex items-center"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-20 w-20 mr-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
              </svg>
              Back to Dashboard
            </button>
          </div>
          
          <div className="bg-N00 rounded-lg shadow-xl p-24 mb-32">
            <h1 className="text-xl font-bold text-N500 mb-24">Edit Profile</h1>
            
            {error && (
              <div className="bg-R50 border border-R200 text-R500 px-16 py-12 rounded-lg mb-24">
                <p>{error}</p>
              </div>
            )}
            
            {successMessage && (
              <div className="bg-G50 border border-G200 text-G500 px-16 py-12 rounded-lg mb-24">
                <p>{successMessage}</p>
              </div>
            )}
            
            <form onSubmit={handleSubmit}>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-24">
                {/* Profile Picture */}
                <div className="md:col-span-2 flex flex-col items-center mb-24">
                  <div className="w-96 h-96 rounded-full overflow-hidden mb-16 bg-N50">
                    {previewUrl ? (
                      <Image 
                        src={previewUrl} 
                        alt="Profile Preview" 
                        width={96} 
                        height={96}
                        className="w-full h-full object-cover" 
                      />
                    ) : (
                      <div className="w-full h-full flex items-center justify-center bg-P300 text-N00">
                        <span className="font-semibold text-2xl">{userData.name.charAt(0)}</span>
                      </div>
                    )}
                  </div>
                  
                  <label className="cursor-pointer bg-P50 text-P300 hover:bg-P100 py-8 px-16 rounded-lg transition duration-300">
                    <span>Change Profile Picture</span>
                    <input 
                      type="file" 
                      className="hidden" 
                      accept="image/*"
                      onChange={handleProfilePictureChange}
                    />
                  </label>
                </div>
                
                {/* Personal Information - Read-only */}
                <div>
                  <h2 className="text-lg font-semibold text-N500 mb-16">Personal Information</h2>
                  
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">Full Name</label>
                    <input 
                      type="text" 
                      value={userData.name}
                      className="w-full px-16 py-12 border border-N100 rounded-lg bg-N50"
                      disabled
                    />
                    <p className="text-xs text-N200 mt-4">Name cannot be changed here</p>
                  </div>
                  
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">Email Address</label>
                    <input 
                      type="email" 
                      value={userData.email}
                      className="w-full px-16 py-12 border border-N100 rounded-lg bg-N50"
                      disabled
                    />
                    <p className="text-xs text-N200 mt-4">Email cannot be changed here</p>
                  </div>
                  
                  {/* Bio - Editable */}
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">Bio</label>
                    <textarea 
                      name="bio"
                      value={formData.bio}
                      onChange={handleInputChange}
                      className="w-full px-16 py-12 border border-N100 rounded-lg focus:outline-none focus:ring-2 focus:ring-P300 min-h-32"
                      rows={5}
                      placeholder="Tell us about yourself"
                      maxLength={300} 
                    ></textarea>
                    <p className="text-xs text-N200 mt-4">Maximum 300 characters</p>
                  </div>
                  
                  {/* Class URL - Editable */}
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">Class URL</label>
                    <input 
                      type="url"
                      name="class_url"
                      value={formData.class_url}
                      onChange={handleInputChange}
                      className="w-full px-16 py-12 border border-N100 rounded-lg focus:outline-none focus:ring-2 focus:ring-P300"
                      placeholder="https://your-class-url.com"
                    />
                    <p className="text-xs text-N200 mt-4">Enter the URL for your virtual classroom</p>
                  </div>
                </div>
                
                {/* Track & Password Information */}
                <div>
                  <h2 className="text-lg font-semibold text-N500 mb-16">Program Information</h2>
                  
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">Track</label>
                    <input 
                      type="text" 
                      value={userData.track}
                      className="w-full px-16 py-12 border border-N100 rounded-lg bg-N50"
                      disabled
                    />
                    <p className="text-xs text-N200 mt-4">Track assignment cannot be changed here</p>
                  </div>
                  
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">Cohort</label>
                    <input 
                      type="text" 
                      value={userData.cohort}
                      className="w-full px-16 py-12 border border-N100 rounded-lg bg-N50"
                      disabled
                    />
                    <p className="text-xs text-N200 mt-4">Cohort assignment cannot be changed here</p>
                  </div>
                  
                  <h2 className="text-lg font-semibold text-N500 mb-16 mt-24">Change Password</h2>
                  
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">Current Password</label>
                    <input 
                      type="password" 
                      name="old_password"
                      value={formData.old_password}
                      onChange={handleInputChange}
                      className="w-full px-16 py-12 border border-N100 rounded-lg focus:outline-none focus:ring-2 focus:ring-P300"
                      placeholder="Enter current password"
                    />
                  </div>
                  
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">New Password</label>
                    <input 
                      type="password" 
                      name="new_password"
                      value={formData.new_password}
                      onChange={handleInputChange}
                      className="w-full px-16 py-12 border border-N100 rounded-lg focus:outline-none focus:ring-2 focus:ring-P300"
                      placeholder="Enter new password"
                    />
                  </div>
                  
                  <div className="mb-16">
                    <label className="block text-sm font-medium text-N300 mb-8">Confirm New Password</label>
                    <input 
                      type="password" 
                      name="new_password_confirm"
                      value={formData.new_password_confirm}
                      onChange={handleInputChange}
                      className="w-full px-16 py-12 border border-N100 rounded-lg focus:outline-none focus:ring-2 focus:ring-P300"
                      placeholder="Confirm new password"
                    />
                  </div>
                </div>
              </div>
              
              <div className="flex justify-end mt-32 gap-16">
                <button 
                  type="button"
                  onClick={handleCancel}
                  className="bg-N100 text-N400 py-12 px-24 rounded-lg hover:bg-N200 transition duration-300"
                >
                  Cancel
                </button>
                <button 
                  type="submit"
                  disabled={submitting}
                  className={`bg-P300 text-N00 py-12 px-24 rounded-lg hover:bg-P200 transition duration-300 ${
                    submitting ? "opacity-75 cursor-not-allowed" : ""
                  }`}
                >
                  {submitting ? "Saving..." : "Save Changes"}
                </button>
              </div>
            </form>
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

export default EditMentorProfile;