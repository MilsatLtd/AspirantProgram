import Image from 'next/image';
import plusIcon from '../../../Assets/plus-icon.svg'
import minusIcon from '../../../Assets/minus-icon.svg'
import { useState } from 'react';
interface faqItemProps {
    question: string;
    answer: string;
    key: number;
    isPage: boolean;
}

const Faqitem = ( props: faqItemProps) => {
    const [showAnswer, setShowAnswer] = useState(false)
  return (
    <div className='flex flex-col gap-32 w-full transition-all delay-150 ease-in-out relative overflow-hidden'>
        <div className={`flex flex-row justify-between py-16 z-20 cursor-pointer ${props.isPage ? "bg-N00 border-[0.5px] border-P57" : "bg-P50"} px-32 rounded-md`}
         onClick={()=> setShowAnswer(!showAnswer)}
        >
            <h4 className='font-semibold lg:text-lg text-m-sm lg:leading-[36px] leading-[24px] text-N400 '>{props.question}</h4>
            <Image src={showAnswer ? minusIcon :plusIcon } alt='plus-icon' className='h-auto w-auto'
            />
        </div>        
        <div className={`pl-16 pr-52 transition-all delay-300 ease-in-out absolute z-0 ${showAnswer ? "relative top-0 ": "  top[-20%]"}`}>
            <p className='lg:text-lg text-m-sm lg:leading-[36px] leading-[24px] font-medium text-N300'>{props.answer}</p>
        </div>
    </div>
  )
}

export default Faqitem