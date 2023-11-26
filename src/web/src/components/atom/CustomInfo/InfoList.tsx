import React, { useState } from 'react'
import Image from 'next/image'
import checkIcon from '../../../Assets/checked.svg'
import forwardIcon from '../../../Assets/forwardGrey-icon.svg'

interface infoListType {
    title: string
    list: Array<{
        id: number;
        [key: string]: any;
    }>;
}
const InfoList = (props: infoListType) => {
  return (
    <div className='flex flex-col lg:space-y-32 space-y-24'
    >
    <div className='pb-16 flex flex-row items-center justify-between'
    >
        <div className='space-y-16'>
            <h2 className='lg:leading-[32px] leading-[28px] lg:text-base text-m-base text-N400 lg:font-extrabold font-semibold'>{props.title}</h2>
            <hr className="border-[2px] border-G200 transition-all delay-150 ease-in-out w-[7rem]"></hr>
        </div>  
    </div>
    <ul className='flex flex-col gap-16 '>
       {
           props.list.map((listItem) => {
               return (
                   <li key={listItem.id} className='flex gap-16'>
                       <Image src={checkIcon} alt='check-icon' className='w-auto h-auto'/>
                       <p className='text-m-sm md:text-[18px] leading-[24px] md:leading-[32px] text-N300'>{listItem.criteria}</p>
                   </li>
               )
           })
       }
       </ul>
</div>
  )
}

export default InfoList