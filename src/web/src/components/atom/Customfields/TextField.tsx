import React from 'react'

interface TextFieldType {
    label: string;
    onTextChange: React.ChangeEventHandler<HTMLInputElement> | undefined;
    type: string;
    error: string | undefined;
    inputStyle: string;
    containerStyle: string;
}

const TextField = (props: TextFieldType) => {
  return (
    <div className={`flex flex-col gap-8 ${props.containerStyle}`}>
        <div className='flex flex-col gap-4'>
         <label className='text-[16px] leading-[28px] text-N400 lg:font-semibold md:font-semibold font-medium'>{props.label}</label>
        </div>
        <input
            className={`py-10 px-16 text-[16px] leading-[28px] font-medium outline-none rounded-md border-[1px] focus:border-P300
            ${
              props.error ? "border-R200" : "border-N75"
            } 
            ${props.inputStyle}`}
            type={props.type}
            onChange={props.onTextChange}    
        />
        <span className="h-[2px] text-R300 text-sm">{props.error}</span>
    </div>
  )
}

export default TextField