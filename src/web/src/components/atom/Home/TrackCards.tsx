import Image from "next/image";
import Link from "next/link";
import React, {useState } from "react";
import nextArrow from "../../../Assets/nextArrow.svg";
import { TrackCardsInfo } from "@/utils/data";

const TrackCards = () => {

    const [activeCard, setActiveCard] = useState(1)
  return (
    <section className="lg:px-96 md:px-48 px-16 text-center flex flex-col justify-center lg:items-center md:items-center lg:gap-50 gap-24 mt-58 mb-[122.9px] z-20 relative ">
      <div className="text-center items-center justify-center gap-12 lg:p-0 md:p-0 px-52 flex flex-col">
        <h2 className="lg:text-[2.7em] text-m-lg lg:leading-[40px] leading-[28px] text-center font-semibold text-N400">
          Not sure where to start?
        </h2>
        <p className="lg:text-lg lg:w-[600px] text-m-base font-medium lg:leading-[36px] leading-[28px] text-N200 text-center ">
        Navigate your GIS learning journey with our expertly curated courses to make informed career choices.
        </p>
      </div>  

      <div className=" overflow-auto overscroll-contain scrollbar-hide cursor-grab lg:overflow-visible md:w-full md:h-full lg:w-full lg:h-full py-16">
      <div className="lg:grid lg:grid-cols-3 grid grid-flow-col w-full overflow md:flex md:flex-row md:justify-center md:items-center md:grid-cols-2 lg:gap-40 gap-16 transition-all delay-150 ease-in-out">
        {TrackCardsInfo.map((trackcard) => {
          return (
            trackcard.id < 4 &&
            <div
              key={trackcard.id}
              className={`lg:p-24 p-16  ${trackcard.id === activeCard ? "": null} transition-all lg:w-auto lg:h-auto  w-[253px] h-full delay-100 ease-in-out shadow-card border-[0.5px] flex flex-col lg:gap-28 md:gap-28 gap-10 border-P50 bg-N00  col-span-1 rounded-[24px]`}
              onMouseEnter={() => setActiveCard(trackcard.id)}
              onMouseLeave={()=> setActiveCard(2)}
            >
              <div className="w-full rounded-[16px] lg:h-[180px] md:h-[140px] h-[115px] ">
                <Image
                  src={trackcard.picture}
                  alt={trackcard.name}
                  className=" object-cover rounded-[16px] w-full h-full"
                  priority
                />
              </div>
              <div className="flex flex-col lg:gap-24 gap-10">
                <h2 className="font-semibold lg:text-lg text-m-sm text-start lg:leading-[36px] leading-[24px] text-N400">
                  {trackcard.name}
                </h2>
                <Link href={trackcard.route} className="flex items-center">
                  <span className="lg:text-base text-m-sm font-medium lg:leading-[32px] leading-[16px] text-P300">
                    Learn more
                  </span>
                  <Image src={nextArrow} alt="next-arrow" />
                </Link>
              </div>
            </div>
          );
        })}
      </div>
      </div>
      <div>
        <Link
            href={"explore"}
            className="text-N00 px-32 py-14 bg-P300 transition-all delay-150 ease-in-out hover:bg-P200 text-center rounded-lg font-semibold leading-[32px] text-base"
        >
            Explore Tracks
        </Link>
      </div>
      
    </section>
  );
};

export default TrackCards;
