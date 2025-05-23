import { useState } from "react";
import Image from "next/image";
import Link from "next/link";
import { useRouter } from "next/router";
import axios from "axios";
import Head from "next/head";
import Logo from "../../Assets/logo.svg";
import { Eye, EyeOff } from "lucide-react";

const Login = () => {
  const router = useRouter();
  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [showPassword, setShowPassword] = useState(false);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const togglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    try {
      const response = await axios.post(
        `${process.env.NEXT_PUBLIC_API_ROUTE}auth/login`,
        formData
      );
      
      // Decode the token to get user ID and role
      const payload = response.data.access.split('.')[1];
      const decodedPayload = JSON.parse(atob(payload));
      const userId = decodedPayload.user_id;
      
      // Store token information
      localStorage.setItem("token", response.data.access);
      localStorage.setItem("refreshToken", response.data.refresh);
      localStorage.setItem("userId", userId);
      
      // Determine user role - handle both string and array formats
      let userRole;
      if (Array.isArray(decodedPayload.role)) {
        userRole = decodedPayload.role.includes(2) ? 2 : 1; // Prioritize mentor role if present
        localStorage.setItem("userRoles", JSON.stringify(decodedPayload.role));
      } else {
        userRole = decodedPayload.role;
      }
      localStorage.setItem("userRole", userRole);
      
      // After login, check if the user is a student or mentor
      try {
        // First, try to fetch student data
        const studentResponse = await axios.get(
          `${process.env.NEXT_PUBLIC_API_ROUTE}students/${userId}`,
          { headers: { Authorization: `Bearer ${response.data.access}` } }
        );
        
        // If successful, user is a student - redirect to student dashboard
        console.log("User is a student:", studentResponse.data);
        router.push("/dashboard");
        return;
      } catch (studentError) {
        // If student fetch fails, try mentor data
        try {
          const mentorResponse = await axios.get(
            `${process.env.NEXT_PUBLIC_API_ROUTE}mentors/${userId}`,
            { headers: { Authorization: `Bearer ${response.data.access}` } }
          );
          
          // If successful, user is a mentor - redirect to mentor dashboard
          console.log("User is a mentor:", mentorResponse.data);
          router.push("/mentor-dashboard");
          return;
        } catch (mentorError) {
          // If both fail, we have an issue with the user role
          console.error("Failed to determine user role:", studentError, mentorError);
          throw new Error("Unable to determine user role. Please contact support.");
        }
      }
    } catch (err) {
      console.error("Login error:", err);
      setError(
        err.response?.data?.detail || err.message || 
        "Login failed. Please check your credentials."
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      <Head>
        <title>Login | Milsat Aspirant Program</title>
      </Head>
      <div className="flex min-h-screen">
        {/* Left side - Form */}
        <div className="w-full lg:w-1/2 flex flex-col justify-center px-16 lg:px-48 xl:px-96">
          <div className="w-full max-w-md mx-auto py-24">
            <div className="text-center mb-24">
              <Link href="/">
                <div className="inline-block">
                  <Image src={Logo} alt="MAP-logo" className="h-auto w-auto" />
                </div>
              </Link>
              <h1 className="mt-16 text-2xl md:text-3xl font-bold tracking-tight text-N500">
                Welcome back
              </h1>
              <p className="mt-8 text-sm text-N200">
                Sign in to access your account
              </p>
            </div>

            {error && (
              <div className="bg-R50 border-l-4 border-R300 p-16 mb-16">
                <p className="text-R400 text-sm">{error}</p>
              </div>
            )}

            <form className="space-y-24" onSubmit={handleSubmit}>
              <div>
                <label
                  htmlFor="email"
                  className="block text-sm font-medium text-N300"
                >
                  📧 Email address
                </label>
                <div className="mt-6">
                  <input
                    id="email"
                    name="email"
                    type="email"
                    autoComplete="email"
                    required
                    value={formData.email}
                    onChange={handleChange}
                    className="appearance-none block w-full px-12 py-12 border border-N75 rounded-lg shadow-xl placeholder-N100 focus:outline-none focus:ring-2 focus:ring-P300 focus:border-P300 sm:text-sm"
                    placeholder="your.email@example.com"
                  />
                </div>
              </div>

              <div>
                <label
                  htmlFor="password"
                  className="block text-sm font-medium text-N300"
                >
                  🔑 Password
                </label>
                <div className="mt-6 relative">
                  <input
                    id="password"
                    name="password"
                    type={showPassword ? "text" : "password"}
                    autoComplete="current-password"
                    required
                    value={formData.password}
                    onChange={handleChange}
                    className="appearance-none block w-full px-12 py-12 border border-N75 rounded-lg shadow-xl placeholder-N100 focus:outline-none focus:ring-2 focus:ring-P300 focus:border-P300 sm:text-sm"
                    placeholder="••••••••"
                  />
                  <button
                    type="button"
                    onClick={togglePasswordVisibility}
                    className="absolute inset-y-0 right-0 flex items-center pr-12 text-N200 hover:text-N300"
                  >
                    {showPassword ? (
                      <EyeOff className="h-16 w-16" />
                    ) : (
                      <Eye className="h-16 w-16" />
                    )}
                  </button>
                </div>
              </div>

              <div className="flex items-center justify-between">
                <div className="flex items-center">
                  <input
                    id="remember-me"
                    name="remember-me"
                    type="checkbox"
                    className="h-16 w-16 text-P300 focus:ring-P300 border-N75 rounded"
                  />
                  <label
                    htmlFor="remember-me"
                    className="ml-8 block text-sm text-N200"
                  >
                    Remember me
                  </label>
                </div>

                <div className="text-sm">
                  <Link
                    href="/reset-password"
                    className="font-medium text-P300 hover:text-P200"
                  >
                    Forgot your password?
                  </Link>
                </div>
              </div>

              <div>
                <button
                  type="submit"
                  disabled={loading}
                  className="w-full flex justify-center py-12 px-16 border border-transparent rounded-lg shadow-card text-sm font-semibold text-N00 bg-P300 hover:bg-P200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-P300 disabled:opacity-50"
                >
                  {loading ? "Signing in..." : "Sign in"}
                </button>
              </div>
            </form>

            <div className="mt-24 text-center">
              <p className="text-sm text-N200">
                Don't have an account?{" "}
                <Link
                  href="/apply"
                  className="font-medium text-P300 hover:text-P200"
                >
                  Apply now
                </Link>
              </p>
            </div>
          </div>
        </div>

        {/* Right side - Image/Content */}
        <div className="hidden lg:block lg:w-1/2 bg-P300">
          <div className="flex items-center justify-center h-full px-48">
            <div className="max-w-md text-N00">
              <h2 className="text-2xl font-bold mb-24">
                Empower Your Future with Milsat
              </h2>
              <p className="text-lg mb-32">
                Join the Milsat Aspirant Program and embark on a journey to accelerate your tech career.
              </p>
              <div className="grid grid-cols-2 gap-16">
                <div className="bg-white/10 p-16 rounded-lg">
                  <h3 className="font-semibold mb-8">Mentorship</h3>
                  <p className="text-sm">Learn from industry experts and experienced professionals.</p>
                </div>
                <div className="bg-white/10 p-16 rounded-lg">
                  <h3 className="font-semibold mb-8">Innovation</h3>
                  <p className="text-sm">Solve real-world problems with cutting-edge technologies.</p>
                </div>
                <div className="bg-white/10 p-16 rounded-lg">
                  <h3 className="font-semibold mb-8">Community</h3>
                  <p className="text-sm">Connect with like-minded individuals and build your network.</p>
                </div>
                <div className="bg-white/10 p-16 rounded-lg">
                  <h3 className="font-semibold mb-8">Growth</h3>
                  <p className="text-sm">Develop skills that will propel your career forward.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Login;