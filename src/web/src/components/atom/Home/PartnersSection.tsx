import React from "react";
import { Partners, MobileAppPlayStoreLink } from "@/utils/data";
import PlayStore from "@/Assets/Playstore.svg";
import Image from "next/image";
import Link from "next/link";

const PartnersSection = () => {
  return (
    <div className="relative flex lg:gap-32 gap-5 items-center">
      <div>
        <span className="text-sm text-N300 font-semibold leading-[20px]">
          In partnership with:
        </span>
        {Partners.map((partner) => {
          return (
            <div key={partner.id} className="col-span-1">
              <Image
                src={partner.logo}
                alt={partner.name}
                className="object-fit h-auto w-auto"
              />
            </div>
          );
        })}
      </div>
      <div className="mt-24">
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
  );
};

export default PartnersSection;
