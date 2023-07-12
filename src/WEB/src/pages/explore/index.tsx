import Hero from '@/components/atom/Explore/Hero'
import MapGain from '@/components/atom/Explore/MapGain'
import Mobilefeature from '@/components/atom/Explore/Mobilefeature'
import TracksEnroll from '@/components/atom/Explore/TracksEnroll'
import Upskill from '@/components/atom/Explore/Upskill'
import FaqList from '@/components/atom/Faq/FaqList'
import Faqitem from '@/components/atom/Faq/Faqitem'
import Footer from '@/components/organism/Footer'
import Header from '@/components/organism/Header'
import React from 'react'

const explore = () => {
  return (
    <div className='lg:space-y-[160px] md:space-y-[100px] space-y-[72px]'>
      <div className='lg:h-screen'>
        <Header showNavLinks={true} showApplyButton={true} />
        <Hero/>
      </div>
      <TracksEnroll />
      <Mobilefeature />
      <MapGain />
      <Upskill />
      <FaqList isPage={false}/>
      <Footer />
      </div>
  )
}

export default explore