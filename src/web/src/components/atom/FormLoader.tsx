import { Circle } from "rc-progress";

interface FormLoaderType {
  percent: number;
}


const FormLoader = (props: FormLoaderType) => {

  return (
    <div className="flex gap-16 items-center">
      <div className="w-[21.3px] h-[21.3px]">
      <Circle percent={props.percent} strokeWidth={15} strokeColor="#803785" strokeLinecap='round' trailColor="#F2EBF3" trailWidth={15} /> 
      </div>
      <h3 className="text-N200 lg:text-base md:text-base text-m-base font-semibold lg:leading-[32px] leading-[28px]">
        Step {props.percent/ 50 } of 2
      </h3>
    </div>
  );
};

export default FormLoader;
