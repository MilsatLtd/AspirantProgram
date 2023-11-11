import React from "react";
import BottomLine from "../atom/BottomLine";
import logo from "../../Assets/logo_white.svg";
import Image from "next/image";
import { socialMediaIcon } from "../../utils/data";
import { routes } from "@/utils/data"
import Link from "next/link";
import BgContour from "../../Assets/Contourextract.svg"

const Footer = () => {
  const { navLinks, quickLinks, tracks } = routes;
  return (
    <div className="md:h-[400px] h-[600px] w-full">
      <div className=" bg-N400 h-full">
        <div className="h-full w-full flex flex-col bg-cover bg-no-repeat  lg:bg-cover" 
        style={{
          backgroundImage: `url(${BgContour.src})`
        }}
        >
          <div className="md:h-[95%] h-[90%] lg:px-96 px-24 flex md:flex-row flex-col items-center md:justify-between ">
          <div className=" flex-1 flex flex-col h-full justify-evenly">
            <div className="flex flex-col md:gap-24 gap-10">
              <Link href="/">
               <Image src={logo} alt="Map-logo" />
              </Link>
              
              <span className="font-medium md:text-[14px] text-sm leading-[20px] text-N00">
                Powered by Milsat Technologies
              </span>
            </div>
            <div className="flex gap-[12.8px] mt-[38px]">
              {socialMediaIcon.map((socialMedia, index) => {
                return (
                  <Link href={socialMedia.link} key={index}  target="_blank"
                  rel="noopener noreferrer" className="h-[3em] w-[3em] flex items-center justify-center rounded-full bg-N00 cursor-pointer">
                    <Image src={socialMedia.icon} alt={socialMedia.name} />
                  </Link>
                );
              })}
            </div>
          </div>
            <div className="flex-1 flex lg:gap-[6.5em] md:gap-[4em] gap-[1.2em]  md:justify-end">
              <ul className="flex flex-col gap-6">
                {navLinks.map((navLink, index) => {
                  return (
                    <li key={index} className="md:text-[18px] text-sm leading-[32px] text-N00 transition-all ease-in-out delay-150 transform hover:text-P200">
                      <Link href={navLink.link}>{navLink.name}</Link>
                    </li>
                  );
                })}
              </ul>
              <ul className="flex flex-col gap-6">
                <li className="md:text-[14px] text-sm leading-[32px] text-N00">
                  Quick Links
                </li>
                {quickLinks.map((quickLink, index) => {
                  return (
                    <li key={index} className="md:text-[18px] text-sm leading-[32px] text-N00 transition-all ease-in-out delay-150 transform hover:text-P200">
                      <Link href={quickLink.link}>{quickLink.name}</Link>
                    </li>
                  );
                })}
              </ul>
              <ul className="flex flex-col gap-6">
                <li className="md:text-[14px] text-sm leading-[20px] text-N00">
                  Tracks
                </li>
                {tracks.map((track, index) => {
                  return (
                    <li key={index} className="md:text-[18px] text-sm leading-[32px] text-N00 transition-all ease-in-out delay-150 transform hover:text-P200">
                      <Link href={track.link}>{track.name}</Link>
                    </li>
                  );
                })}
              </ul>

            </div>
          </div>
          <span className="w-full text-center text-N00 leading-[16px] font-medium text-[10px]">
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
      <BottomLine />
    </div>
  );
};

export default Footer;
