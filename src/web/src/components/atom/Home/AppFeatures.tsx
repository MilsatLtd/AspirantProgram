import React, { useState } from "react";
import { ProgrammeFeatures } from "@/utils/data";
import blurEffectDownLeft from "../../../Assets/blur-effect-down-left.svg";
import blurEffectDownRight from "../../../Assets/blur-effect-down-right.svg";
import Image from "next/image";

interface FeatureCardProps {
  id: number;
  title: string;
  description: string;
}

const AppFeatures = () => {
  const [activeFeature, setActiveFeature] = useState(0);

  const { title, howItWorks, featuresIcons } = ProgrammeFeatures;
  return (
    <div className="h-[800px] flex items-center justify-center bg-P50">
      <div className="mx-auto max-w-[65vw] space-y-[5.18em]">
        <h2 className="text-3xl font-bold text-N500 text-center">{title}</h2>
        <div className="flex gap-40">
          <div className="flex-1">
            {howItWorks.map((feature, index) => {
              return (
                <FeatureCard
                  key={index}
                  id={feature.id}
                  title={feature.title}
                  description={feature.description}
                />
              );
            })}
          </div>
          <div className="flex-1 grid grid-cols-2">
            {featuresIcons.map((feature, index) => {
              return (
                <div
                  key={index}
                  className="col-span-1 flex items-center justify-center"
                >
                  <div className="">
                    <Image src={feature.icon} alt="feature-icon" />
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
};

export default AppFeatures;

const FeatureCard = ({ id, title, description }: FeatureCardProps) => {
  return (
    <div className="flex gap-32 min-h-[10em]">
      <div className="relative flex flex-col gap-0 items-center">
        <div className="w-[55px] h-[64px] bg-G400 flex items-center justify-center rounded-[22px]">
          <span className="text-white font-bold text-xl leading-[53px]">
            {id}
          </span>
          </div>
          <hr className="h-full w-4 bg-G400 items-center"></hr>
      </div>
      <div className="space-y-4 pb-11">
        <h3 className="text-xl text-N500 font-bold">{title}</h3>
        <p className="text-lg text-N400 font-medium">{description}</p>
      </div>
    </div>
  );
};
