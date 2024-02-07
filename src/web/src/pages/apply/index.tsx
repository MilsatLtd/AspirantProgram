import ApplicantInfo from "@/components/atom/application/ApplicationInfo";
import Footer from "@/components/organism/Footer";
import ApplicationForm from "@/components/organism/Forms/ApplicationForm";
import Header from "@/components/organism/Header";
import { useApplyMutation, useGetCurrentCohortQuery, useSendEmailMutation } from "@/store/apiSlice/applyApi";
import { useAppDispatch } from "@/store/hooks";
import { setAllTracks } from "@/store/slice/AllTracks";
import { ApplicationEmailTemplate, applictionTimeline } from "@/utils/data";
import {getAllTracksDetails}  from "@/utils/apiFunctions"
import SubmitInfo from "@/components/atom/application/SubmitInfo";
import blurEffectTop from "../../Assets/blur-effect-top.svg";
import { ThreeCircles } from "react-loader-spinner";
import React, { useEffect, useState } from "react";
import Head from 'next/head'

const ApplicationPage = () => {
  const {
    data: currentChort,
    isSuccess: currentChortAvailable,
    isLoading,
  } = useGetCurrentCohortQuery(undefined);
  const [
    submitApplication,
    { isSuccess: isSubmitted, isLoading: isSubmitting, isError: isSubmitError, error: submitError },
  ] = useApplyMutation();

  const [
    sendApplicationEmail,
    {}
  ] =  useSendEmailMutation();
  const dispatch = useAppDispatch();
  const [show, setShow] = useState(false);
  const [SubmissionStatus, setSubmissionStatus] = useState("");
  const [email, setEmail] = useState<string | undefined>();
  const [chorts, setChorts] = useState([] as any);

  const { startDate, endDate } = applictionTimeline



  useEffect(() => {
    if (currentChortAvailable) {
      setChorts(currentChort);
      const name = getAllTracksDetails(currentChort)
      dispatch(setAllTracks({track: name.trackInfo}));
    } 
  }, [currentChortAvailable, isLoading, currentChort, dispatch]);





  const removePopup = (status: boolean) => {
    setShow(status)
  }

  // POST application data to the backend API endpoint
  const handleSubmitApplication = async (_allresponse: FormData) => {
    submitApplication(_allresponse)
  }

  // Checks if the application is submitted or not
  useEffect(() => {
    if(isSubmitted){
        setShow(true)
        setSubmissionStatus("Your application has been sent successfully and under review")
        sendApplicationEmail({email: email ? email : "", subject: "Application to the Milsat Aspirant Programme", message: ApplicationEmailTemplate})
      }
      if(isSubmitting){
        setShow(false)
      }
      if(isSubmitError){
        setShow(true)
        setSubmissionStatus("An Error Occured, Please Try Again")
      }
  }, [isSubmitted, isSubmitting, isSubmitError, submitError])



  return (
    <>
    
    <Head>
    <title>Apply to Cohort</title>
      <meta name="description" content="Apply to MAP live Cohort" />
      <meta name="keywords" content="MAP, Aspirant Programmer, GIS Training, Milsat, Educaton, GIS Skills, GIS Mentorship, Esri,Fundalmental of GIS, Field Mapping, Data collection, Africa GIS, Data, learning GIS" />
      
      {/* Add a link to your favicon (replace 'favicon.ico' with your actual favicon) */}
      <link rel="icon" href="/favicon.ico" />

      {/* Add an Open Graph image (replace 'og-image.jpg' with your actual image)
      <meta property="og:image" content="/og-image.jpg" /> */}

      {/* Add a canonical URL if needed */}
      <link rel="canonical" href="https://aspirant.milsat.africa/apply" />

      {/* Add your CSS styles or external stylesheets */}
      <link rel="stylesheet" href="/styles.css" />

      {/* Add your logo image (replace 'logo.png' with your actual logo) */}
      <link rel="apple-touch-icon" sizes="180x180" href="/logo.png" />
      <link rel="icon" type="image/png" sizes="32x32" href="/logo.png" />
      <link rel="icon" type="image/png" sizes="16x16" href="/logo.png" />

      {/* Specify the viewport for responsive design */}
      <meta name="viewport" content="width=device-width, initial-scale=1" />
    </Head>
    <div className="h-full">
      { isLoading || isSubmitting  && (
        <div className="z-20 w-screen fixed right-0 h-full bg-[rgba(0,0,0,0.5)] flex items-center justify-center">
          <div className="flex z-15 flex-col items-center gap-20">
            <ThreeCircles
              height="100"
              width="100"
              color="#b58bb8"
              wrapperStyle={{}}
              wrapperClass=""
              visible={true}
              ariaLabel="three-circles-rotating"
              outerCircleColor=""
              innerCircleColor=""
              middleCircleColor=""
            />
          </div>
        </div>
      )}
      {show && (
        <div className={`w-screen h-screen z-40 fixed right-0 top-0 bottom-0 bg-[rgba(0,0,0,0.5)] flex items-center justify-center`}
        >
          <div className="flex z-40 flex-col  w-[90%] md:w-[35%] items-center gap-20">
            <SubmitInfo info={SubmissionStatus} removePopup={(status)=>removePopup(status)} />
          </div>
        </div>
      )}
      <div
        className="bg-no-repeat relative"
        style={{
          backgroundImage: `url(${blurEffectTop.src})`,
        }}
      >
        <Header showNavLinks={true} showApplyButton={false} />
        <section className="grid lg:grid-cols-12 grid-cols-1 lg:px-96 md:px-48 px-16 mt-[3rem] mb-[200px]">
          <ApplicantInfo applicationTimeline={{start_date: startDate, end_date: endDate}} />
          <ApplicationForm  postResponse={(form)=> handleSubmitApplication(form)} passEmail={(email)=>setEmail(email)}/>
        </section>
      </div>
      <Footer />
    </div>
    </>
  );
};

export default ApplicationPage;
