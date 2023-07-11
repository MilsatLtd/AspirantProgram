import Header from '@/components/organism/Header'
import HeroBlurEffectRight from '../../../Assets/hero-blur-effect-right.svg'
import HeroBlurEffectLeft from '../../../Assets/hero-blur-effect-left.svg'
import React from 'react'
import Image from 'next/image'
import HeroContent from '@/components/atom/Home/HeroContent'

const Jumbotron = () => {
  return (
    <div className='w-full relative flex flex-col'>
        
        <div className='absolute lg:top-0 md:top-0 bottom-0 left-0 z-0 lg:h-[180%] h-[160%] w-full'>
            <Image src={HeroBlurEffectLeft} alt="Blur-effect-left"  className='h-full lg:w-full w-full'  />
        </div>
            <Header showNavLinks={true} showApplyButton={true} />
            <HeroContent/>

        <div className='absolute top-[30%] lg:top-0 md:top-0 md:right-0 bottom-0 left-0 z-0 lg:h-[180%] md:h-[180%] h-full'>
            <Image src={HeroBlurEffectRight} alt="Blur-effect-right"  className='h-full lg:w-full md:w-full w-auto'  />
        </div>
    </div>
  )
}

export default Jumbotron