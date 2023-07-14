import ApplicantInfo from "@/components/atom/application/ApplicationInfo";
import Footer from "@/components/organism/Footer";
import ApplicationForm from "@/components/organism/Forms/ApplicationForm";
import Header from "@/components/organism/Header";
import { useApplyMutation, useGetCurrentCohortQuery } from "@/store/apiSlice/applyApi";
import { useAppDispatch } from "@/store/hooks";
import { setAllTracks } from "@/store/slice/AllTracks";
import {getAllTracksDetails}  from "@/utils/apiFunctions"
import SubmitInfo from "@/components/atom/application/SubmitInfo";
import blurEffectTop from "../../Assets/blur-effect-top.svg";
import { ThreeCircles } from "react-loader-spinner";
import React, { useEffect, useState } from "react";

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
  const dispatch = useAppDispatch();
  const [show, setShow] = useState(false);
  const [SubmissionStatus, setSubmissionStatus] = useState("");
  const [chorts, setChorts] = useState([] as any);



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
      }
      if(isSubmitting){
        setShow(false)
      }
      if(isSubmitError){
        setShow(true)
        setSubmissionStatus("Your application was not successfull. Email already exist")
      }
  }, [isSubmitted, isSubmitting, isSubmitError, submitError])



  return (
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
          <div className="flex z-40 flex-col w-[35%] items-center gap-20">
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
          <ApplicantInfo applicationTimeline={{start_date: "00 November, 2023", end_date: "00 December, 2023"}} />
          <ApplicationForm  postResponse={(form)=> handleSubmitApplication(form)}/>
        </section>
      </div>
      <Footer />
    </div>
  );
};

export default ApplicationPage;
