import React, { useState } from "react";
import Image from "next/image";
import sign from "../../../Assets/sign.svg";
import checkIcon from "../../../Assets/checked.svg";
import forwardIcon from "../../../Assets/forwardGrey-icon.svg";
import { eligibility } from "../../../utils/data";
import InfoList from "../CustomInfo/InfoList";
import { applicationInfoType } from "@/utils/types";

const ApplicantInfo = (props: applicationInfoType) => {
  const [allInfo, showAllInfo] = useState(false);
  return (
    <aside className="lg:col-span-5 relative z-0 col-span-1 w-full flex flex-col lg:gap-56 md:gap-48 gap-32 lg:mt-[4.5rem] mt-[0.5rem]">
      <div className="relative flex flex-col w-[20rem] h-[8rem]">
        <h2 className="font-extrabold lg:text-lg text-m-lg  lg:leading-[36px] leading-[28px] text-N400 z-10">
          You’re one step closer to achieving your goal
        </h2>
        <Image
          src={sign}
          alt="sign"
          className="absolute lg:top-[1.1rem] md:top-[1.1rem] top-[0.2rem] z-0 left-[-2.5rem] w-auto h-auto"
        />
      </div>
      <InfoList title={"Eligibility Criteria"} list={eligibility} />
      <div
        className="flex flex-col lg:space-y-32 space-y-24"
      >
        <div className="pb-16 flex items-center justify-between"
        onClick={() => showAllInfo(!allInfo)}
        >
          <div className="space-y-16 ">
            <h2 className="lg:leading-[32px] leading-[28px] lg:text-base text-m-base text-N400 lg:font-extrabold font-semibold">
              Application Timeline
            </h2>
            <hr
              className="border-[2px] border-G200 transition-all delay-150 ease-in-out w-[7rem]"
            ></hr>
          </div>
          <Image
            src={forwardIcon}
            alt="forward"
            className={`h-auto w-auto lg:hidden block ${
              allInfo && "transform rotate-90"
            }`}
          />
        </div>
        {
          allInfo && 
          <div className="flex gap-16">
          <Image src={checkIcon} alt="check-icon" className="w-auto h-auto" />
          <p className="lg:text-base text-m-base text-N300 font-medium lg:leading-[32px] leading-[28px] w-[358px]">
            Application opens{" "}
            <span className="font-semibold">{props.applicationTimeline.start_date}</span>{" "}
            and closes{" "}
            <span className="font-semibold">{props.applicationTimeline.end_date}</span>.
          </p>
        </div>
        }
         <div className="lg:flex md:hidden hidden gap-16">
          <Image src={checkIcon} alt="check-icon" className="w-auto h-auto" />
          <p className="lg:text-base text-m-base text-N300 font-medium lg:leading-[32px] leading-[28px] w-[358px]">
            Application opens{" "}
            <span className="font-semibold">{props.applicationTimeline.start_date}</span>{" "}
            and closes{" "}
            <span className="font-semibold">{props.applicationTimeline.end_date}</span>.
          </p>
        </div>
       
      </div>
    </aside>
  );
};

export default ApplicantInfo;
