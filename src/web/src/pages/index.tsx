import AppFeatures from '@/components/atom/Home/AppFeatures'
import ApplySection from '@/components/atom/Home/ApplySection'
import ChortInfo from '@/components/atom/Home/ChortInfo'
import Jumbotron from '@/components/organism/Home/Jumbotron'
import KnowlegeGap from '@/components/atom/Home/KnowlegeGap'
import TrackCards from '@/components/atom/Home/TrackCards'
import Footer from '@/components/organism/Footer'
import Header from '@/components/organism/Header'
import React from 'react'
import AdvertText from '@/components/atom/Home/AdvertText'

const index = () => {
  return (
    <div className='w-full '>
      <div className='relative'>
        <Jumbotron />
      </div>
      <section className='relative'>
      <TrackCards />
      <KnowlegeGap />
      <ChortInfo />
      <AppFeatures/>
      <ApplySection />
      </section>
      <Footer />
    </div>
  )
}

export default index