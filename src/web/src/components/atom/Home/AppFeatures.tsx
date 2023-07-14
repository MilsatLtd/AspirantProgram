import React, { useState } from 'react'
import { ProgrammeFeatures } from '@/utils/data'
import blurEffectDownLeft from "../../../Assets/blur-effect-down-left.svg"
import blurEffectDownRight from "../../../Assets/blur-effect-down-right.svg"
import Image from 'next/image'

const AppFeatures = () => {
const [activeFeature, setActiveFeature] = useState(0)
  return (
    <div className='h-[800px] relative'>
            <Image src={blurEffectDownLeft} alt="Blur-effect-right" className='absolute top-0 bottom-0 left-0 h-full z-0' />
            <div className="absolute h-full w-full top-0 flex lg:items-start items-center justify-center z-10">
                <div className='lg:w-[70%] md:w-[72%] w-full px-16 flex flex-col gap-[80px]'>
                    {
                        ProgrammeFeatures.map((feature) => {
                            return(
                                <div key={feature.id} className='flex lg:items-center md:items-center lg:gap-56 md:32 gap-24'
                                onMouseEnter={()=> setActiveFeature(feature.id)}
                                onMouseLeave={()=> setActiveFeature(0)}
                                >
                                        <Image src={feature.icon} alt={feature.title}
                                        className={`lg:w-[96px] lg:h-[96px] md:[64px] md:h-[64px] w-[48px] h-[48px] transition-all delay-200 ease-in-out ${activeFeature === feature.id ? " rotate-180": null}`} 
                                        />
                                    <div className='flex-grow flex flex-col gap-16'>
                                        <h2 className='lg:text-xl md:text-lg  text-m-xl text-N400 leading-[28px] lg:leading-[40px] font-semibold'>{feature.title}</h2>
                                        <p className='lg:text-lg md:text-base text-m-base text-N300 lg:leading-[36px] leading-[28px] font-medium'>{feature.description}</p>
                                    </div>
                                </div>
                            )
                        } )
                    }
                </div>
            </div>
            <Image src={blurEffectDownRight} alt="Blur-effect-right" className='absolute top-0 bottom-0 w-[50%] h-full right-0 z-0' />
    </div>
  )
}

export default AppFeatures