import React from "react";
import { useRouter } from "next/router";
import Image from "next/image";
import Header from "@/components/organism/Header";
import BottomLine from "@/components/atom/BottomLine";
import BgContourTexture from "../../../Assets/contourTexture.svg";
import redirect from "../../../Assets/redirect.svg";
import Link from "next/link";
import InfoList from "@/components/atom/CustomInfo/InfoList";
import { AvailableTracks } from "@/utils/data";

const TrackDetails = () => {
  const router = useRouter();
  const trackId = router.query.trackId;

  return (
    <div>
      {AvailableTracks.map((Track) => {
        return Track.id === trackId ? (
          <div key={Track.id}>
            <header
              className="h-screen bg-P50 bg-cover bg-no-repeat "
              style={{
                backgroundImage: `url(${BgContourTexture.src})`,
              }}
            >
              <Header showNavLinks={true} showApplyButton={false} />

              <section className="lg:px-96 md:px-48 px-16 py-24 lg:h-[609px] h-full gap-[64px] my-0 mx-auto flex lg:flex-row flex-col lg:items-center w-full">
                <div className="grid lg:grid-rows-4 lg:gap-[64px] gap-48 mt-52 lg:mt-0 flex-1">
                  <div className="lg:row-span-3 flex flex-col gap-24 lg:w-[500px] w-[250px]">
                    <h2 className="lg:text-3xl text-m-2xl font-semibold lg:leading-[68px] lg:w-[300px] leading-[48px]">
                      {Track.trackName}
                    </h2>
                    <p className="lg:text-lg text-m-lg w-[341px] lg:w-full font-medium lg:leading-[36px] leading-[28px] text-N200">
                      {Track.description}
                    </p>
                  </div>
                  <div className="lg:row-span-1 ">
                    <Link
                      href="/apply"
                      className="py-[17px] px-32 flex items-center leading-[28px] gap-12 bg-P300 hover:bg-P200  text-N00 rounded-lg w-max"
                    >
                      <span>Enroll</span>
                      <Image src={redirect} alt="redirect-icon" />
                    </Link>
                  </div>
                </div>
                <div className="flex-1 flex flex-col lg:items-center">
                  <div>
                    <div className="pb-16 space-y-16 ">
                      <h2 className="lg:leading-[32px] leading-[24px] lg:text-base text-m-sm text-N400 lg:font-extrabold font-semibold">
                        Application Timeline
                      </h2>
                      <hr className="w-[6rem] border-[2px] border-G200 "></hr>
                      <p className="text-N300 lg:text-base text-m-sm lg:leading-[32px] leading-[24px] font-semibold">
                        00 November - 00 December
                      </p>
                    </div>
                    <div className="pb-16 space-y-16 ">
                      <h2 className="lg:leading-[32px] leading-[24px] lg:text-base text-m-sm text-N400 lg:font-extrabold font-semibold">
                        Learning Timeline
                      </h2>
                      <hr className="w-[6rem] border-[2px] border-G200 "></hr>
                      <p className="text-N300 lg:text-base text-m-sm lg:leading-[32px] leading-[24px] font-semibold">
                        {Track.learningTimeLine}
                      </p>
                    </div>
                  </div>
                </div>
              </section>
            </header>
            <div className="lg:px-[206px] md:px-48 px-16 py-[168px] flex flex-col gap-[88px]">
                {Track.TrackInfo.map((info, index) => {
                return <InfoList key={index} title={info.name} list={info.list} />;
                })}
            </div>
            
          </div>
        ) : null;
      })}

      <BottomLine />
    </div>
  );
};

export default TrackDetails;
