import { useState } from "react";
import Image from "next/image";
import Link from "next/link";
import Head from "next/head";
import axios from "axios";
import Logo from "../../Assets/logo.svg";

const ResetPassword = () => {
  const [formData, setFormData] = useState({
    email: "",
    profile_type: "Student",
  });
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState({ text: "", type: "" });

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setMessage({ text: "", type: "" });

    try {
      await axios.post(
        `${process.env.NEXT_PUBLIC_API_ROUTE}auth/forgot_password`,
        formData
      );
      
      setMessage({
        text: "Password reset link has been sent to your email.",
        type: "success",
      });
      setFormData({ ...formData, email: "" });
    } catch (err) {
      setMessage({
        text: err.response?.data?.detail || "Failed to send reset link. Please try again.",
        type: "error",
      });
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      <Head>
        <title>Reset Password | MilSat Aspirant Program</title>
      </Head>
      <div className="flex min-h-screen">
        {/* Left side - Banner */}
        <div className="hidden lg:block lg:w-1/2 bg-P300">
          <div className="flex items-center justify-center h-full px-48">
            <div className="max-w-md text-N00">
              <div className="mb-32">

              </div>
              <h2 className="text-2xl font-bold mb-16">Reset Your Password</h2>
              <p className="text-base mb-16">
                We understand that you might forget your password sometimes. 
                Don't worry! We'll help you get back to your account quickly and securely.
              </p>
            </div>
          </div>
        </div>

        {/* Right side - Form */}
        <div className="w-full lg:w-1/2 flex flex-col justify-center px-16 lg:px-48 xl:px-96">
          <div className="w-full max-w-md mx-auto py-24">
            <div className="text-center mb-24">
              <Link href="/">
                <div className="inline-block">
                <Image src={Logo} alt="MAP-logo" className="h-auto w-auto" />
                </div>
              </Link>
              <h1 className="mt-16 text-2xl md:text-3xl font-bold tracking-tight text-N500">
                Reset your password
              </h1>
              <p className="mt-8 text-sm text-N200">
                Enter your email address and we'll send you a password reset link
              </p>
            </div>

            {message.text && (
              <div 
                className={`${
                  message.type === "success" 
                    ? "bg-G50 border-G300 text-G500" 
                    : "bg-R50 border-R300 text-R400"
                } border-l-4 p-16 mb-16`}
              >
                <p className="text-sm">{message.text}</p>
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
                  htmlFor="profile_type"
                  className="block text-sm font-medium text-N300"
                >
                  🎭 Profile Type
                </label>
                <div className="mt-6">
                  <select
                    id="profile_type"
                    name="profile_type"
                    required
                    value={formData.profile_type}
                    onChange={handleChange}
                    className="appearance-none block w-full px-12 py-12 border border-N75 rounded-lg shadow-xl placeholder-N100 focus:outline-none focus:ring-2 focus:ring-P300 focus:border-P300 sm:text-sm"
                  >
                    <option value="Student">Student</option>
                    <option value="Mentor">Mentor</option>
                  </select>
                </div>
              </div>

              <div>
                <button
                  type="submit"
                  disabled={loading}
                  className="w-full flex justify-center py-12 px-16 border border-transparent rounded-lg shadow-card text-sm font-semibold text-N00 bg-P300 hover:bg-P200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-P300 disabled:opacity-50"
                >
                  {loading ? "Sending..." : "Send reset link"}
                </button>
              </div>
            </form>

            <div className="mt-24 text-center">
              <p className="text-sm text-N200">
                Remember your password?{" "}
                <Link
                  href="/login"
                  className="font-medium text-P300 hover:text-P200"
                >
                  Back to login
                </Link>
              </p>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default ResetPassword;