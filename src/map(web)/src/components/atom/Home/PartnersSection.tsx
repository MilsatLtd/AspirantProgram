import React from 'react'
import { Partners } from '@/utils/data'
import Image from 'next/image'

const PartnersSection = () => {
  return (
    <div className='relative'>
                <span className='text-sm text-N300 font-semibold leading-[20px]'>In partnership with:</span>
                {
                    Partners.map((partner)=> {
                        return(
                            <div key={partner.id}className='col-span-1'>
                                <Image src={partner.logo} alt={partner.name} className='object-fit h-auto w-auto' />
                            </div>
                        )
                    })
                }
    </div>
  )
}

export default PartnersSection