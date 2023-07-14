import router from "next/router";
import closePopup from "../../../Assets/closePopup.svg"
import Image from "next/image";

const SubmissionInfo = () => {
  return (
    <div className="px-26 py-26 bg-N00 rounded-lg">
        <div className="flex justify-end w-full">
            <Image src={closePopup} alt="close-popup" className="h-auto w-auto cursor-pointer" onClick={()=>{router.push("/")}}/>
        </div>
        <div className="flex items-center justify-center gap-32">
            <h4 className="text-xl text-N300 leading-[36px] ">Your application has been sent and under review</h4>
            <button
            className="py-12 px-40 bg-P300 hover:bg-P200  text-N00 rounded-lg font-semibold"
            onClick={()=>{router.push("/apply")}}
            >
            Apply
            </button>
        </div>
    </div>
  )
}

export default SubmissionInfo