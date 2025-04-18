import React from "react";
import BgContourTexture from "../../../Assets/contourTexture2.svg";
import PlayStore from "../../../Assets/Playstore.svg";
import MobileView from "../../../Assets/mobile-view.svg";
import featureIcon from "../../../Assets/line-icon.svg";
import Image from "next/image";
import { MobileFeatures, MobileAppPlayStoreLink } from "../../../utils/data";
import Link from "next/link";
import NavLink from "../NavLink";

const Mobilefeature = () => {
  return (
    <div
      className="lg:px-96 md:px-48 px-16 py-[86px] flex items-center flex-col md:gap-48 gap-56 lg:flex-row lg:justify-between w-full bg-cover bg-no-repeat "
      style={{
        backgroundImage: `url(${BgContourTexture.src})`,
        backgroundColor: "#F9F9F9",
      }}
    >
      <div className="flex-1 flex w-[288px] h-[288px] items-center lg:w-[500px] lg:h-[500px] justify-center lg:justify-start">
        <Image src={MobileView} alt="mobile-app" className="h-full w-full" />
      </div>
      <div className="gap-32 flex flex-col">
        <ul className="flex-1 flex flex-col gap-48">
          {MobileFeatures.map((feature, index) => {
            return (
              <li
                key={feature.id}
                className="flex lg:gap-28 gap-16 items-center lg:w-[547px]"
              >
                <Image
                  src={featureIcon}
                  alt="feature-icon"
                  className="h-auto w-auto"
                />
                <p className="lg:text-lg text-m-base leading-[28px] text-N400 font-medium leadng-[36px]">
                  {feature.description}
                </p>
              </li>
            );
          })}
        </ul>
        <div className="flex flex-col gap-6">
          <p className="lg:text-base text-m-base leading-[28px]">
            Available on mobile
          </p>
          <Link
            href={`${MobileAppPlayStoreLink}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image
              src={PlayStore}
              alt="play-store-icon"
              className="h-auto w-auto"
            />
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Mobilefeature;
