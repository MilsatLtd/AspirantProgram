import Image from "next/image";
import dropArrow from "../../../Assets/downArrow.svg";
import { useEffect, useState } from "react";
interface dropDownFieldType {
  label: string;
  error: string | undefined;
  dropDownStyle: string;
  placeholder: string;
  inputStyle: string;
  containerStyle: string;
  textValue: { label: string; value: string | number } | undefined;
  onTextChange: (data: string | number) => void;
  options: Array<{
    label: string | null ;
    value: string | number | null;
  }>;
}

const DropDownField = (props: dropDownFieldType) => {
  // Component States
  const [dropdown, showDropdown] = useState(false);
  const [value, setValue] = useState<{
    valueText: string | null;
  }>({
    valueText: "",
  });

  useEffect(() => {
    if (props.textValue) {
      setValue({ valueText: props.textValue.label });
      props.onTextChange(props.textValue.value);
    }
  }, [props, props.textValue]);

  return (
    <div className={`flex flex-col gap-8 relative ${props.containerStyle}`}>
      <div className="flex flex-col gap-4">
        <label className="text-[16px] leading-[28px] text-N400 lg:font-semibold font-medium">
          {props.label}
        </label>
      </div>
      <div
        className={`py-10 px-16 flex justify-between text-[16px] leading-[28px] font-medium rounded-md border-[1px] cursor-pointer ${
          props.error ? "border-R200" : dropdown ? "border-P300" : "border-N75"
        } ${props.inputStyle}`}
        onClick={() => showDropdown(!dropdown)}
      >
        <p
          className={`${
            value.valueText
              ? "text-N400 text-[16px] font-medium"
              : "text-N100 text-[16px] leading-[28px] font-medium"
          } `}
        >
          {value.valueText === "" ? props.placeholder : value.valueText}
        </p>
        <Image
          src={dropArrow}
          alt="drop-down"
          className={`w-auto h-auto transition-all delay-100 ease-in-out  ${
            dropdown ? "rotate-180" : null
          }`}
        />
      </div>
      <div className="transition-all delay-150 ease-in-out">
        <ul
          className={`flex flex-col w-full right-0 top-[95%] z-20 gap-14 bg-N00 p-16 shadow-2xl absolute rounded-lg ${props.dropDownStyle}  ${
            dropdown ? "block" : "hidden"
          }`}
        >
          {props.options && props.options.map((option, id) => {
            return (
              <li
                key={id}
                className="flex w-full items-center text-[16px] text-N200 font-semibold py-8 px-16 gap-16 rounded-lg hover:bg-P50"
                onClick={() => {
                  if(option.value !== null){
                    props.onTextChange(option.value);
                    setValue({ valueText: option.label });
                    showDropdown(!dropdown);
                  }
                }}
              >
                <span>{option.label}</span>
              </li>
            );
          })}
        </ul>
        <span className="h-[2px] text-R300 text-sm">{props.error}</span>
      </div>
    </div>
  );
};

export default DropDownField;
