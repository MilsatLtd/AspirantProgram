import { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import { useRouter } from "next/router";
import Head from "next/head";
import axios from "axios";
import Logo from "../../Assets/logo.svg";

const ResetPasswordConfirm = () => {
  const router = useRouter();
  const { token } = router.query;
  
  const [formData, setFormData] = useState({
    token: "",
    password: "",
    confirm_password: "",
  });
  
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState({ text: "", type: "" });
  const [passwordStrength, setPasswordStrength] = useState({
    score: 0,
    feedback: "",
  });

  useEffect(() => {
    if (token) {
      setFormData((prev) => ({ ...prev, token }));
    }
  }, [token]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
    
    // Simple password strength check
    if (name === "password") {
      let score = 0;
      let feedback = "";
      
      if (value.length >= 8) score += 1;
      if (/[A-Z]/.test(value)) score += 1;
      if (/[a-z]/.test(value)) score += 1;
      if (/[0-9]/.test(value)) score += 1;
      if (/[^A-Za-z0-9]/.test(value)) score += 1;
      
      if (score < 3) feedback = "Weak password";
      else if (score < 5) feedback = "Moderate password";
      else feedback = "Strong password";
      
      setPasswordStrength({ score, feedback });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (formData.password !== formData.confirm_password) {
      setMessage({ text: "Passwords do not match", type: "error" });
      return;
    }
    
    setLoading(true);
    setMessage({ text: "", type: "" });

    try {
      await axios.post(
        `${process.env.NEXT_PUBLIC_API_ROUTE}auth/reset_password/`,
        formData
      );
      
      setMessage({
        text: "Password reset successful! You can now login with your new password.",
        type: "success",
      });
      
      // Redirect to login after 3 seconds
      setTimeout(() => {
        router.push("/login");
      }, 3000);
      
    } catch (err) {
      setMessage({
        text: err.response?.data?.detail || "Failed to reset password. Please try again.",
        type: "error",
      });
    } finally {
      setLoading(false);
    }
  };

  const getStrengthColor = () => {
    if (passwordStrength.score < 3) return "bg-R300";
    if (passwordStrength.score < 5) return "bg-S300";
    return "bg-G300";
  };

  return (
    <>
      <Head>
        <title>Create New Password | MilSat Aspirant Program</title>
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
                Create new password
              </h1>
              <p className="mt-8 text-sm text-N200">
                Enter your new password below
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
                  htmlFor="password"
                  className="block text-sm font-medium text-N300"
                >
                  New Password
                </label>
                <div className="mt-6">
                  <input
                    id="password"
                    name="password"
                    type="password"
                    required
                    value={formData.password}
                    onChange={handleChange}
                    className="appearance-none block w-full px-12 py-12 border border-N75 rounded-lg shadow-xl placeholder-N100 focus:outline-none focus:ring-2 focus:ring-P300 focus:border-P300 sm:text-sm"
                    placeholder="••••••••"
                    minLength={8}
                  />
                </div>
                {formData.password && (
                  <div className="mt-8">
                    <div className="w-full bg-N50 rounded-full h-2">
                      <div 
                        className={`h-2 rounded-full ${getStrengthColor()}`} 
                        style={{ width: `${(passwordStrength.score / 5) * 100}%` }}
                      ></div>
                    </div>
                    <p className="text-xs mt-4 text-N200">
                      {passwordStrength.feedback}
                    </p>
                  </div>
                )}
              </div>

              <div>
                <label
                  htmlFor="confirm_password"
                  className="block text-sm font-medium text-N300"
                >
                  Confirm Password
                </label>
                <div className="mt-6">
                  <input
                    id="confirm_password"
                    name="confirm_password"
                    type="password"
                    required
                    value={formData.confirm_password}
                    onChange={handleChange}
                    className="appearance-none block w-full px-12 py-12 border border-N75 rounded-lg shadow-xl placeholder-N100 focus:outline-none focus:ring-2 focus:ring-P300 focus:border-P300 sm:text-sm"
                    placeholder="••••••••"
                  />
                </div>
              </div>

              <div>
                <button
                  type="submit"
                  disabled={loading}
                  className="w-full flex justify-center py-12 px-16 border border-transparent rounded-lg shadow-card text-sm font-semibold text-N00 bg-P300 hover:bg-P200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-P300 disabled:opacity-50"
                >
                  {loading ? "Resetting..." : "Reset Password"}
                </button>
              </div>
            </form>
          </div>
        </div>

        {/* Right side - Image/Content */}
        <div className="hidden lg:block lg:w-1/2 bg-P300">
          <div className="flex items-center justify-center h-full px-48">
            <div className="max-w-md text-N00">
              <div className="mb-32">

              </div>
              <h2 className="text-2xl font-bold mb-16">Create a Strong Password</h2>
              <p className="text-base mb-24">
                Protect your account with a secure password that meets the following criteria:
              </p>
              <ul className="space-y-12">
                <li className="flex items-start">
                  <span className="mr-8">✓</span>
                  <span>At least 8 characters long</span>
                </li>
                <li className="flex items-start">
                  <span className="mr-8">✓</span>
                  <span>Contains uppercase and lowercase letters</span>
                </li>
                <li className="flex items-start">
                  <span className="mr-8">✓</span>
                  <span>Includes numbers</span>
                </li>
                <li className="flex items-start">
                  <span className="mr-8">✓</span>
                  <span>Contains special characters</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default ResetPasswordConfirm;