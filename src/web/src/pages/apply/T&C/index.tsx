import Footer from "@/components/organism/Footer";
import Header from "@/components/organism/Header";
import { TAndCDetails } from "@/utils/data"
import blurEffectTopRight from "../../../Assets/blur-effect-top-right.svg"
import React from "react";

const TermsConditionsPage = () => {

  return (
    <div>
      <div
      className="w-full bg-no-repeat bg-cover"
      style={{
        backgroundImage: `url(${blurEffectTopRight.src})`
      }}
      >
      <Header showNavLinks={false} showApplyButton={true} />
      <section className="w-full lg:my-[6%] my-[56px] lg:px-0 md:px-0 px-16">
        <h2 className="font-bold lg:text-xl text-m-xl lg:leading-[40px] leading-[30px] text-N400 text-center lg:mb-[88px] mb-[56px]">Terms and Conditions</h2>
        <div className="lg:w-[45%] w-full my-0 mx-auto">

            {
                TAndCDetails.map((TCdetail)=> {
                    return(
                        <div key={TCdetail.id} className="pb-16 space-y-16 "
                        >
                            <h2 className="lg:leading-[32px] leading-[28px] text-m-base lg:text-base text-N400 font-bold">
                                {TCdetail.title}
                            </h2>
                            <hr className="w-[6rem] border-[2px] border-G200 transition-all delay-150 ease-in-out"></hr>
                            <p className="lg:text-base text-m-base text-N200 font-medium lg:leading-[32px] leading-[28px]">{TCdetail.description}</p>
                         </div>
                    )
                })
            }
        </div>
      </section>
      </div>
      <Footer />
    </div>
  );
};

export default TermsConditionsPage;