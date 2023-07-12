import Footer from '@/components/organism/Footer'
import Header from '@/components/organism/Header'
import React from 'react'
import { Faqs } from '@/utils/data'
import Faqitem from '@/components/atom/Faq/Faqitem'
import FaqList from '@/components/atom/Faq/FaqList'
import Upskill from '@/components/atom/Explore/Upskill'

const faqs = () => {
  return (
    <div>
        <Header showNavLinks={true} showApplyButton={true} />
        <div className='space-y-[200px] md:space-y-[120px] py-[72px]'>
            <FaqList isPage={true}/>
            <Upskill />
        </div>
      <Footer />
    </div>
  )
}

export default faqs