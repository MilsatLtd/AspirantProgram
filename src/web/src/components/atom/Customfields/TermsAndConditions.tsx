import React from 'react';
import { termsAndConditions } from '@/utils/data';
import Link from 'next/link';


const TermsAndConditions = () => {
    return (
        <div className='w-full flex flex-col gap-20'>
            <h2 className='font-semibold text-base text-N300 leading-[32px]'>Terms and Conditions</h2>
            <ul className='flex flex-col gap-20'>
                <li className='flex gap-[19px] items-center'>
                    <div className='flex items-center'>
                        <input type="checkbox" className='accent-[#803785] w-[18px] h-[18px]' />
                    </div>
                    <p className='text-sm text-N300 font-medium leading-[20px]'>{termsAndConditions.firstTerms}</p>
                </li>
                <li className='flex gap-[19px] items-center'>
                    <div className='flex items-center'>
                        <input type="checkbox" className='accent-[#803785] w-[18px] h-[18px]' />
                    </div>
                    <p className='text-sm text-N300 font-medium leading-[20px]'> I hereby declare that i have read through the <span className='text-P300 cursor-pointer font-semibold hover:underline'><Link href={"/apply/T&C"}>Terms and Condition</Link></span> of this Application</p>
                </li>
                <li className='flex gap-[19px] items-center'>
                    <div className='flex items-center'>
                        <input type="checkbox" className='accent-[#803785] w-[18px] h-[18px]' />
                    </div>
                    <p className='text-sm text-N300 font-medium leading-[20px]'>{termsAndConditions.secondTerms}</p>
                </li>
            </ul>
        </div>
    )
}

export default TermsAndConditions