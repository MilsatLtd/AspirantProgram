import Image from 'next/image'
import GainImage from '../../../Assets/gain-image.jpg'
import { oppourtunity } from '@/utils/data'
import React from 'react'

const MapGain = () => {
  return (
    <div className='lg:px-96 md:px-48 px-16  flex items-center flex-col md:gap-48 gap-56  lg:flex-row lg:justify-between w-full bg-cover bg-no-repeat '>
        <div className='flex items-center justify-start flex-1'>
            {
                oppourtunity.map((opp) => {
                    return(
                        <div key={opp.id} className='lg:w-[501px] w-full flex flex-col lg:gap-24 gap-32'>
                            <div className='flex gap-12 items-center'>
                                <span className='h-[8px] w-[8px] rounded-full bg-G200'></span>
                            <h5 className='font-semibold text-[18px] leading-[32px] text-N300 '>{opp.title}</h5>
                            </div>
                            
                            <ul className='flex flex-col gap-32'>
                                {
                                opp.oppourtunityList.map((oppItem) => {
                                    return(
                                        <li key={oppItem.id} className='font-medium lg:text-[32px] text-m-xl lg:leading-[40px] leading-30px text-N400'>{oppItem.description}</li>
                                    )
                                })
                                }
                            </ul>
                        </div>
                    )
                })
            }
        </div>
        <div className="flex-1 flex justify-end">
            <Image src={GainImage} alt="gain-image" className='h-auto w-auto' />
        </div>
    </div>
  )
}

export default MapGain