import Image from 'next/image'
import React from 'react'
import aspirantImage from "../../../Assets/hero-img.jpg"
import heroTriangleTexture from "../../../Assets/hero-triangle-texture.svg"

const HeroImage = () => {
  return (
    <div className='col-span-1 flex w-full h-full lg:items-baseline items-center justify-center bg-no-repeat lg:pt-[120px] lg:py-0 py-[56px] md:static relative  lg:justify-end '
    >
        <Image priority src={heroTriangleTexture} alt={"hero-triangle-texture"} className='lg:w-auto lg:h-auto md:w-[500px] md:h-[550px] w-auto h-auto absolute top-[-10px] lg:top-0 lg:right-[2.3rem]'/>
        <div className='lg:h-[500px] lg:w-[576px] md:min-w-[403px] md:min-h-[367px] w-[330px] h-[267px] relative'>
            <Image src={aspirantImage} alt="aspirant-picture" className='lg:min-w-auto lg:min-h-auto  w-full h-full rounded-[42px] object-cover'/>
        </div>
    </div>
  )
}

export default HeroImage