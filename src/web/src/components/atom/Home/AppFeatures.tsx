import { ProgrammeFeatures } from "@/utils/data";
import Image from "next/image";

interface FeatureCardProps {
  id: number;
  title: string;
  description: string;
}

const AppFeatures = () => {

  const { title, howItWorks, featuresIcon } = ProgrammeFeatures;
  return (
    <div className="pt-[4.6em] mt-[2em] pb-[8em] flex items-center justify-center bg-P50">
      <div className="mx-auto lg:max-w-[65vw] md:max-w-[80vw] max-w-[90vw] space-y-[5.18em]">
        <h2 className="md:text-3xl text-xl font-bold text-N500 text-center">
          {title}
        </h2>
        <div className="flex md:flex-row flex-col  md:gap-[11em] gap-[5em]">
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
          <div className="flex-1 flex flex-col justify-center md:gap-[2em] gap-10 ">
            <div className="bg-P300 rounded-[2em] md:rounded-[4em] md:p-[2.36em] p-[1.6em] md:h-max h-[8em] w-max">
              <Image
                src={featuresIcon.rocket}
                alt="Rocket-icon"
                className="w-full h-full"
              />
            </div>
            <div className="flex items-center gap-[2em]">
              <div className="md:h-full h-[8em]">
                <Image
                  src={featuresIcon.globe}
                  alt="Globe-icon"
                  className="w-full h-full"
                />
              </div>
              <div className="md:rounded-[4em] rounded-[2em] md:p-[3.125em] p-[1.6em] md:h-full h-[8em] bg-S300">
                <Image
                  src={featuresIcon.planet}
                  alt="Planet-icon"
                  className="w-full h-full "
                />
              </div>
            </div>
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
      <div className="flex flex-col items-center">
        <div className="w-[55px] md:h-[64px] bg-G400 flex items-center justify-center rounded-[22px]">
          <span className="text-white font-bold text-xl leading-[53px]">
            {id}
          </span>
        </div>
        <hr className="h-full w-[0.2em] bg-G400 items-center"></hr>
      </div>
      <div className="space-y-4 pb-11">
        <h3 className="md:text-xl text-lg text-N500 font-bold">{title}</h3>
        <p className="md:text-lg text-base text-N400 font-medium">
          {description}
        </p>
      </div>
    </div>
  );
};
