import AppFeatures from '@/components/atom/Home/AppFeatures'
import ApplySection from '@/components/atom/Home/ApplySection'
import ChortInfo from '@/components/atom/Home/ChortInfo'
import Jumbotron from '@/components/organism/Home/Jumbotron'
import KnowlegeGap from '@/components/atom/Home/KnowlegeGap'
import TrackCards from '@/components/atom/Home/TrackCards'
import Footer from '@/components/organism/Footer'
import Header from '@/components/organism/Header'
import React from 'react'
import Head from 'next/head'
import AdvertText from '@/components/atom/Home/AdvertText'

const index = () => {
  return (
    <>
    <Head>
    <title>Milsat Aspirant Programme</title>
      <meta name="description" content="A Platform to Learn High-Demand Geo-Skills" />
      <meta name="keywords" content="MAP, Aspirant Programmer, GIS Training, Milsat, Educaton, GIS Skills, GIS Mentorship, Esri,Fundalmental of GIS, Field Mapping, Data collection, Africa GIS, Data, learning GIS" />
      
      {/* Add a link to your favicon (replace 'favicon.ico' with your actual favicon) */}
      <link rel="icon" href="/favicon.ico" />

      {/* Add an Open Graph image (replace 'og-image.jpg' with your actual image)
      <meta property="og:image" content="/og-image.jpg" /> */}

      {/* Add a canonical URL if needed */}
      <link rel="canonical" href="https://aspirant.milsat.africa/" />

      {/* Add your CSS styles or external stylesheets */}
      <link rel="stylesheet" href="/styles.css" />

      {/* Add your logo image (replace 'logo.png' with your actual logo) */}
      <link rel="apple-touch-icon" sizes="180x180" href="/logo.png" />
      <link rel="icon" type="image/png" sizes="32x32" href="/logo.png" />
      <link rel="icon" type="image/png" sizes="16x16" href="/logo.png" />

      {/* Specify the viewport for responsive design */}
      <meta name="viewport" content="width=device-width, initial-scale=1" />
    </Head>
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
    </>
  )
}

export default index