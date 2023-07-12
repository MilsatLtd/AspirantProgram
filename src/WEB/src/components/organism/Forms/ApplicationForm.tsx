import FormLoader from '@/components/atom/FormLoader'
import React, { useEffect, useRef, useState } from 'react'
import { useApplyMutation } from '@/store/apiSlice/applyApi';
import backIcon from '@/Assets/backIcon.svg'
import { reasonInfo, applicationFormType } from '@/utils/types'
import FormSectionA from './FormSectionA'
import FormSectionB from './FormSectionB'
import Image from 'next/image';

const ApplicationForm = (props:applicationFormType ) => {

  const [changeSection, setChangeSection] = useState("sectionA");
  const [applicationResponse , setApplicationResponse] = useState({})
  const [percent, setPercent] = useState(50);
  const topRef = useRef<HTMLDivElement>(null);
  
  // Scroll page back to new form section
  const scrollToSection = () => {
    if (topRef.current) {
      topRef.current.scrollIntoView({ behavior: "smooth" });
    }
  };


  // merge application data from form section A and B
  const mergeResponse = (data: any) =>{
    const _allresponse = {
      ...applicationResponse, ...data}
    setApplicationResponse({...applicationResponse, ...data})
    const Form = new FormData()
    for(const key in _allresponse){
      Form.append(key, _allresponse[key])
    }
    props.postResponse(Form)
  }
 


  return (
    <main className='col-span-7 bg-N00 p-32 rounded-3xl drop-shadow-2xl h-full' ref={topRef}>
        <h3 className='text-N300 lg:text-lg text-m-lg lg:leading-[36px] leading-[28px] font-semibold'>Start Application</h3>
        <div className={`flex ${changeSection === "sectionB"? "justify-between": "justify-end"} mt-16`}>
          {
            changeSection === "sectionB" &&
            <div className='flex flex-row gap-12 items-center cursor-pointer'
            onClick={()=>{setChangeSection("sectionA"); setPercent(50)}}
            >
              <Image src={backIcon} alt="back-icon}" className='h-auto w-auto' />
              <span>Back</span>
            </div>
          }
           <FormLoader percent={percent}/> 
        </div>
        <section className='mt-[39.44px] transition delay-150 ease-in-out' >
          <div className={`${changeSection === "sectionB" ? "block": "hidden"}`}>
            <FormSectionB passData={(data: reasonInfo)=> mergeResponse(data)} />
          </div>
          <div className={` ${changeSection === "sectionA"? "block": "hidden"}`}>
            <FormSectionA passData={(data) => setApplicationResponse(data)} changeSection={()=> {setChangeSection("sectionB"); setPercent(100); scrollToSection()}}/>
          </div>        
        </section>
    </main>
  )
}

export default ApplicationForm