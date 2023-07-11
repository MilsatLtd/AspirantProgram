import { TrackCardsInfo } from "@/utils/data";
import nextArrow from "../../../Assets/nextArrow.svg";
import Image from "next/image";
import Link from "next/link";
import { useState } from "react";

const TracksEnroll = () => {
  return (
    <div className="lg:px-96 md:px-48 px-16 flex flex-col gap-56">
        <h2 className="text-center font-medium lg:text-xl text-m-xl px-48 text-N300 lg:leading-[40px] leading-[30px]">Enroll on any available tracks</h2>
        <div className="grid lg:grid-cols-3 md:grid-cols-2 grid-cols-1 gap-32">
            {TrackCardsInfo.map((trackcard) => {
            return (
                <div
                key={trackcard.id}
                className={`lg:p-24 p-22 transition-all delay-100 ease-in-out shadow-lg border-[0.5px] flex flex-col lg:gap-28 gap-14 border-P50 bg-N00  col-span-1 rounded-[24px]`}
                >
                <div className="w-full rounded-[16px] lg:max-h-[180px] h-[156px]">
                    <Image
                    src={trackcard.picture}
                    alt={trackcard.name}
                    className="w-full h-full object-cover rounded-[16px]"
                    />
                </div>
                <div className="flex flex-col lg:gap-24 gap-14">
                    <h2 className="font-semibold lg:text-lg text-m-base text-start leading-[36px] text-N400">
                    {trackcard.name}
                    </h2>
                    <div className="flex justify-between items-center">
                        <Link href={trackcard.route} className="flex items-center">
                        <span className="lg:text-base text-m-sm font-medium lg:leading-[32px] leading-[24px] text-P300">
                            Learn more
                        </span>
                        <Image src={nextArrow} alt="next-arrow" />
                        </Link>
                        <Link href={"/apply"} className="flex items-center border-[1.4px] border-P300 py-4 rounded-lg px-32" >
                            <span className="text-P300 text-[16px] font-semibold leading-[28px]">Enroll</span>
                        </Link>
                    </div>
                </div>
            </div>
            );
            })}
        </div>
    </div>
  )
}

export default TracksEnroll