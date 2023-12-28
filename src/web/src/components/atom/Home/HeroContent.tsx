import React from 'react'
import Image from 'next/image'
import HeroImage from './HeroImage'
import topArrow from '../../../Assets/topArrow.svg'
import PlayStore  from '../../../Assets/Playstore.svg'
import {MobileAppPlayStoreLink} from '../../../utils/data'
import Link from 'next/link'
import PartnersSection from './PartnersSection'

const HeroContent = () => {
  return (
    <div className='lg:px-96 md:px-48 px-16 grid lg:grid-cols-2 md:grid-cols-2 lg:gap-0 gap-56 grid-col-1 z-40 relative'>
        <div className='col-span-1 flex flex-col gap-[187px] lg:pt-[197px] pt-[70px] '>
            <div className='flex-grow flex flex-col justify-center lg:gap-[56px] gap-[48px]'>
                <div className='flex flex-col gap-32'>
                    <h1 className='lg:text-[3.56em] text-m-2xl font-extrabold lg:leading-[68px] leading-[48px] text-N500 w-[342px] lg:w-[600px]'>Learn High-Demand Geo-Skills</h1>
                    <p className='lg:text-lg lg:leading-[32px] leading-[28px] font-medium text-N300 w-[342px]  lg:w-[550px]'>Boost your GIS skills and reach full potential with expert-designed courses and mentorship</p>
                </div>
                <Link href={"/apply"} className='flex gap-12 items-center px-32 py-12 bg-P300 rounded-lg z-40 w-max'>
                    <span className='text-[16px] font-semibold text-N00 leading-[28px]'>Join Cohort</span>
                    <Image src={topArrow} alt="top-arrow" className="h-auto w-auto" />
                </Link>
            </div>
            <div className='lg:block hidden z-0'>
                <PartnersSection/>
            </div>
        </div>
            <HeroImage />
            <div className='lg:hidden relative z-0'>
                <PartnersSection/>
            </div>
        </div> 
  )
}

export default HeroContent