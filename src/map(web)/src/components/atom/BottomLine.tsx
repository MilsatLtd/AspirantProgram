import { bottomline } from "@/utils/data"
const BottomLine = () => {
  return (
    <div className="flex h-[7px] md:h-[7px] lg:h-[14px]">
        {
            bottomline.map((rectangle, index)=> {
                return(
                    <div key={index} style={{backgroundColor:`${rectangle.bg_color}`}} className="flex-1 h-full"></div>
                )
            })
        }
        

    </div>
  )
}

export default BottomLine