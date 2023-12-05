import React, { useState } from 'react'
import Image from 'next/image';
import skillCloseIcon from '../../../Assets/skillClose.jpg'

interface MultiTextFieldType{
    label: string;
    placeholder:string;
    containerStyle: string;
    error: string | undefined;
    sendSkills: (skills: string) => void;
}

const MultiTextField = (props: MultiTextFieldType) => {
    const [allSkills, setAllSkills] = useState<Array<string>>([])
    const [potentialSkill, setPotentaialSkills] = useState<string>("")

    const handleAddSkills = (e: any) => {
        const skillName: string = e.target.value
        setPotentaialSkills(skillName)
    }


    const UpdateAddSkills = (event: any) => {
        event.preventDefault();
        if(event.keyCode === 13 || event.key === 'Enter'){ 
            if(potentialSkill !== undefined){
                const UpdatedSkills: string[] = [...allSkills, potentialSkill]
                setAllSkills(UpdatedSkills)
                const skills = UpdatedSkills.toString()
                props.sendSkills(skills)
                setPotentaialSkills("")
            }
            
        }
    }

    const handleAddSkillsButton = () => {
            if(potentialSkill !== undefined){
                const UpdatedSkills: string[] = [...allSkills, potentialSkill]
                setAllSkills(UpdatedSkills)
                const skills = UpdatedSkills.toString()
                props.sendSkills(skills)
                setPotentaialSkills("")
            }
    }

    const removeSkills = (skills: string) => {
        const removedSkills = allSkills.filter((skill)=> skill !== skills)
        setAllSkills(removedSkills)
        props.sendSkills(removedSkills.toString())
    }

  return (
    <div className={` flex flex-col gap-8 relative ${props.containerStyle}`}>
        <div className="flex flex-col gap-4">
        <label className="text-[16px] leading-[28px] text-N400 lg:font-semibold font-medium">
          {props.label}
        </label>
      </div>
      <div className='flex flex-col gap-8 w-full'>
        <div className='flex gap-6 flex-wrap'>
        <input placeholder={props.placeholder} className={`py-10 flex-1 px-16 flex justify-between text-[16px] leading-[28px] font-medium outline-none  focus:border-P300 rounded-md border-[1px] cursor-pointer
            ${
                props.error ? "border-R200" : "border-N75"
              }
        `}
        onChange={handleAddSkills}
        onKeyUp={UpdateAddSkills}
        value={ potentialSkill}
        />
        <div className='flex items-center py-10 px-16 w-max  bg-P300 font-semibold text-white rounded-md cursor-pointer'
        onClick={()=>handleAddSkillsButton()}
        >
            Add Skill
        </div>
        </div>
        
        <div className='flex flex-wrap gap-24 '>
            {
                allSkills.map((skill, id)=> {
                    return(
                        <div key={id} className=' bg-N50 py-4 px-10 flex items-center justify-center gap-8 rounded '>
                            <span className='leading-[24px] text-base font-medium'>
                                {skill}
                            </span>
                            <Image src={skillCloseIcon} alt="skill-close" className='h-auto w-auto cursor-pointer' 
                            onClick={()=> skill && removeSkills(skill)}
                            />
                        </div>
                    )
                })
            }
        </div>
        <span className="max-h-[10px] text-R300 text-sm">{props.error}</span>
        </div>
    </div>
  )
}

export default MultiTextField