import React from "react";
import BottomLine from "../atom/BottomLine";
import logo from "../../Assets/logo_white.svg";
import Image from "next/image";
import { socialMediaIcon } from "../../utils/data";
import Link from "next/link";
import BgContour from "../../Assets/Contourextract.svg"

const Footer = () => {
  return (
    <div className="h-[333px] w-full">
      <div className=" bg-N400 h-full">
        <div className="h-full w-full flex justify-center items-center bg-cover bg-no-repeat  lg:bg-cover" 
        style={{
          backgroundImage: `url(${BgContour.src})`
        }}
        >
          <div className="flex flex-col">
            <div className="flex flex-col gap-24">
              <Link href="/">
               <Image src={logo} alt="Map-logo" />
              </Link>
              
              <span className="font-medium text-[14px] leading-[20px] text-N00">
                Powered by Milsat Technologies
              </span>
            </div>
            <div className="flex justify-center gap-[12.8px] mt-[38px]">
              {socialMediaIcon.map((socialMedia, index) => {
                return (
                  <Link href={socialMedia.link} key={index}  target="_blank"
                  rel="noopener noreferrer" className="py-[9.6px] px-[9.4px] rounded-full bg-N00 cursor-pointer">
                    <Image src={socialMedia.icon} alt={socialMedia.name} />
                  </Link>
                );
              })}
            </div>
            <span className="w-full text-center text-N00 leading-[16px] font-medium text-[10px] mt-[56px]">
              © {new Date().getFullYear()}{" "}
              <a
                href="https://milsat.africa/"
                target="_blank"
                rel="noopener noreferrer"
                className="hover:underline"
              >
                Milsat Technologies
              </a>{" "}
              All Rights Reserved.
            </span>
          </div>
        </div>
      </div>
      <BottomLine />
    </div>
  );
};

export default Footer;
