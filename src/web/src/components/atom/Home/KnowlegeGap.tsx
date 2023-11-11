import React from 'react'
import { knowledgeInfo } from '@/utils/data'
import BgContourTexture from "../../../Assets/contourTexture.svg";

const KnowlegeGap = () => {
  return (
    <div className='lg:px-96 md:px-48 px-16 flex lg:h-[323px] lg:items-center flex-col md:gap-64 gap-24 lg:flex-row lg:justify-between w-full bg-cover bg-no-repeat '
    style={{
        backgroundImage: `url(${BgContourTexture.src})`,
      }}
    >
        <h2 className='font-semibold md:text-2xl text-xl leading-[40px] text-N40 w-[95%] md:w-[40%] lg:w-[25%]'>{knowledgeInfo.title}</h2>
        <p className='md:text-[2em] text-[1.1em] text-N300 font-medium leadng-[32px] lg:w-[50%]'>{knowledgeInfo.description}</p>
    </div>
  )
}

export default KnowlegeGap