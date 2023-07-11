import Image from 'next/image'
import map from '../../../Assets/map-texture.svg'
import React from 'react'

const Upskill = () => {
  return (
    <div className='lg:pl-96 h-[456px] grid lg:grid-cols-2 grid-cols-1 w-full relative'>
        <div className='lg:px-0 px-16 flex items-center'>
            <div className='flex flex-col gap-[21px]'>
                <h3 className='font-semibold lg:text-[48px] text-m-2xl leading-[40px] lg:leading-[43px] text-N400'>Ready to Upskill?</h3>
                <p className='font-medium lg:text-[32px] text-m-xl leading-[30px] lg:leading-[40px] text-N300'>Join our cohort and learn anywhere, around Africa and beyond</p>
            </div>
        </div>
        <div className='col-span-1 flex justify-end lg:absolute lg:h-full lg:w-[65%] w-auto h-auto lg:right-0 '>
            <Image src={map} alt='lg:h-full lg:w-full h-auto w-auto '/>
        </div>
    </div>
  )
}

export default Upskill