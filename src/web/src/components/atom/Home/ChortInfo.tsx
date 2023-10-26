import { ChortMessages } from "@/utils/data"
import backwardIcon from "../../../Assets/backward-icon.svg"
import forwardIcon from "../../../Assets/forward-icon.svg"
import Image from "next/image"
import { useState } from "react"

const ChortInfo = () => {
    const [messageCard, setMessageCard] = useState(0)
    const [position , setPosition] = useState(0)

    const handleMoveLeft = () => {
        if (position === 0) {
            return null
        } else{
            setPosition(position + 300)
        }
        
    }

    const handleMoveRight = () => {
        if (position === -1500) {
            return null
        }else{
            setPosition(position - 300)
        }
        
    }
  return (
    <div className="lg:px-96 md:px-48 px-16 mt-[184px] lg:mb-[184px] w-full h-full">
        <div className="overflow-hidden w-400 h-200 md:w-full md:h-full lg:w-full lg:h-full">
        <div className={`grid lg:grid-cols-3 md:grid-cols-2 h-full w-full lg:grid-flow-dense md:grid-flow-dense grid-flow-col transition-transform ease-in-out duration-300 lg:gap-54 md:gap-24 gap-16`}
        style={{ transform: `translateX(${position}px)` }}
        >
            {
                ChortMessages.map((chortmessage)=> {
                    return (
                        <div
                        key={chortmessage.id}
                        className={`lg:w-full md:w-full lg:col-span-1 md:col-span-1 min-w-[298px] overflow-clip relative transition-all delay-150 ease-in-out ${chortmessage.id === messageCard ? "scale-90": null}`}
                        onMouseEnter={()=> setMessageCard(chortmessage.id)}
                        onMouseLeave={()=> setMessageCard(0)}
                        style={{
                            backgroundColor: `${chortmessage.color}`
                        }}
                        >
                        <Image src={chortmessage.texture} alt="texture" className="absolute lg:right-0 lg:w-auto lg:h-auto z-0 right-[-50px] w-full h-full"/>
                        <div 
                        className=" col-span-1 flex flex-col lg:gap-48 gap-36 lg:px-32 px-24 lg:py-40 py-30 lg:h-[358px] h-[270px] w-full bg-no-repeat bg-auto bg-left"
                        >   
                            <h3 className="lg:text-xl text-m-lg lg:font-bold font-semibold lg:leading-[36px] leading-[24px] text-P50">{chortmessage.title}</h3>
                            <p className="lg:text-lg text-m-base lg:font-medium font-normal lg:leadng-[36px] leading-[24px] text-P50">{chortmessage.message}</p>
                        </div>
                        </div>
                    )
                })
            }
        </div>
        </div>
        <div className="flex w-full justify-end gap-32 mt-28 lg:hidden md:hidden">
            <button className={`w-32 h-32 flex items-center justify-center border-[0.5px] border-N75 rounded-full bg-N00 ${position === -1500 || position < 0  ? "bg-P300":  "bg-N00"}`}
            onClick={handleMoveLeft}
            >
            <Image src={backwardIcon} alt="backward-icon" className="h-auto w-auto" />
        </button>
            <button className={`w-32 h-32 flex items-center justify-center border-[0.5px] border-N75 rounded-full bg-N00  ${position === 0 && position > -1500  ? "bg-P300":  "bg-N00"}`}
            onClick={handleMoveRight}
            >
                <Image src={forwardIcon} alt="forward-icon" className="h-auto w-auto" />
            </button>
        </div>
     
    </div>
  )
}

export default ChortInfo