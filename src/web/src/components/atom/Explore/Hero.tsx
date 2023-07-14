import Image from 'next/image'
import heroImage from '../../../Assets/explore-hero-img.jpg'
import heroCard from '../../../Assets/hero-card.svg'
import React from 'react'

const Hero = () => {
  return (
    <div className='lg:px-96 md:px-48 px-16 grid lg:grid-cols-2 md:grid-cols-2 lg:gap-[100px] gap-56  lg:min-h-[60%] py-[72px] grid-col-1 z-0 relative'>
        <div className='col-span-1 flex flex-col gap-24 justify-center'>
            <h1 className='lg:text-3xl text-m-2xl font-medium lg:leading-[68px] leading-[48px] text-N400 w-[342px] lg:w-[450px]'>Explore the World most demanding skill</h1>
            <p className='lg:text-base lg:leading-[32px] leading-[28px] font-medium text-N200 w-[342px]  lg:w-[500px]'>Empower your GIS journey unlock your full potential with expertly curated Courses and mentorship</p>
        </div>
        <div className='col-span-1 w-full relative flex justify-end items-center'>
          <div className='lg:h-full col-span-1 lg:w-full h-[219px] w-[287px]'>
            <Image src={heroImage} alt='hero-img' className='lg:h-full lg:w-full h-auto w-auto'/>
          </div>
          <div className='absolute lg:left-[-40%] left-[-10%] items-center top-0 lg:w-full lg-h-full w-[300px] h-[80.99px]'>
            <Image src={heroCard} alt='hero-card' className='lg:h-auto lg:w-auto h-auto w-auto' />
          </div>
        </div>   
    </div>
  ) 
}

export default Hero