import React from 'react'
import { knowledgeInfo } from '@/utils/data'
import BgContourTexture from "../../../Assets/contourTexture.svg";

const KnowlegeGap = () => {
  return (
    <div className='lg:px-96 md:px-48 px-16 flex lg:h-[323px] lg:items-center flex-col md:gap-48 gap-24 lg:flex-row lg:justify-between w-full bg-cover bg-no-repeat '
    style={{
        backgroundImage: `url(${BgContourTexture.src})`,
      }}
    >
        <h2 className='font-extrabold text-xl leading-[40px] text-N400 w-[70%] md:w-[40%] lg:w-[20%]'>{knowledgeInfo.title}</h2>
        <p className='text-base text-N300 font-semibold leadng-[32px] lg:w-[50%]'>{knowledgeInfo.description}</p>
    </div>
  )
}

export default KnowlegeGap