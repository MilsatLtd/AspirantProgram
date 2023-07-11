import Link from 'next/link'
import React from 'react'
import applyImage from "../../../Assets/apply-image.jpg"

const ApplySection = () => {
  return (
    <div 
    className='bg-cover bg-center mb-[155px]'
        style={{
            backgroundImage: `url(${applyImage.src})`
        }}
    >
        <div className='flex flex-col gap-[43px] items-center lg:h-[397px] h-[358px] justify-center'
        style={{
            background:`linear-gradient(0deg, rgba(0, 0, 0, 0.65), rgba(0, 0, 0, 0.65))`
          }}
        >
            <div className='flex flex-col justify-center gap-16 px-16 lg:p-0'>
                <h2 className='text-semibold px-22 lg:text-xl text-m-xl lg:leading-[40px] leading-[28px] font-semibold text-P50 text-center'>Apply Now and Unlock Your Potential in GIS</h2>
                <div className='flex justify-center'>
                    <p className='text-center leading-[28px] text-m-lg lg:leading-[32px] lg:text-base text-P50 font-medium w-full md:w-[60%] lg:w-[70%]'> Join our thriving community of learners and take your GIS skills to the next level.</p>
                </div>
               
            </div>
            <Link href={"apply"} className='text-N00 lg:px-48 lg:py-8 py-12 px-40 bg-P300 hover:bg-P200  rounded-lg font-semibold leading-[28px] lg:leading-[32px] text-base' >
                Apply Now!
            </Link>
        </div>
    </div>
  )
}

export default ApplySection