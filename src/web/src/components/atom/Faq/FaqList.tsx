import React from 'react'
import { Faqs } from '@/utils/data'
import Faqitem from '@/components/atom/Faq/Faqitem'

interface FaqListProps {
    isPage: boolean
}

const FaqList = (props: FaqListProps) => {
  return (
        <div className='lg:w-[80%] w-full px-16 md:px-48 mx-auto'>
            <div className='flex flex-col gap-16 w-full justify-center'>
                {
                    props.isPage ?
                    <h2 className='font-semibold text-N400 lg:text-2xl text-m-2xl lg:leading-[56px] leading-[40px] text-center'>Frequently asked questions</h2>:
                    <h2 className='font-semibold text-N400 lg:text-2xl text-m-2xl lg:leading-[56px] leading-[40px] text-center'>FAQ</h2>
                }
                
                <p className='text-center lg:text-[24px] text-m-lg leading-[32px] lg:leading-[36px] font-medium text-N300'>Got questions? Find answer here</p>
            </div>
            <div className='flex flex-col gap-56 mt-[55px]'>
                {
                    Faqs.map((faqType)=>{
                        return(
                            <div key={faqType.id} className='flex flex-col gap-24'>
                                <h3 className='font-semibold lg:text-xl text-N400 text-m-lg leading-[36px] lg:leading-[40px]'>{faqType.faqTitle}</h3>
                                {
                                    faqType.faqList.map((faqitem)=> {
                                        return(
                                            <Faqitem isPage={props.isPage} question={faqitem.question} answer={faqitem.answer} key={faqitem.id} />
                                        )
                                    })
                                }
                            </div>
                        )
                    })
                }
            </div>
        </div>
  )
}

export default FaqList