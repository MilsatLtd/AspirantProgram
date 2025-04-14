import React from "react";
import { termsAndConditions } from "@/utils/data";
import Link from "next/link";

interface termsAndConditionType {
  onFirstTermChange: React.ChangeEventHandler<HTMLInputElement> | undefined;
  onSecondTermChange: React.ChangeEventHandler<HTMLInputElement> | undefined;
  valueForAccurate: boolean | undefined;
  valueForTerms: boolean | undefined;
  errorData: string | undefined;
  errorTerms: string | undefined;
}

const TermsAndConditions = (props: termsAndConditionType) => {
  const [terms, setTerms] = React.useState<Array<string>>([]);

  return (
    <div className="w-full flex flex-col gap-20">
      <h2 className="font-semibold text-base text-N300 leading-[32px]">
        Terms and Conditions
      </h2>
      <ul className="flex flex-col gap-20">
        <li className="flex gap-[19px] items-center">
        <div className={`flex items-center p-[1px] ${ props.errorData && "border-R300 border-2 "}`}>
            <input
              type="checkbox"
              name="accurate"
              defaultChecked={props.valueForAccurate}
              className="accent-[#803785] w-[18px] h-[18px]"
              onChange={props.onFirstTermChange}
            />
          </div>
          <p className="text-sm text-N300 font-medium leading-[20px]">
            {termsAndConditions.firstTerms}
          </p>
        </li>
        <li className="flex gap-[19px] items-center">
          <div className={`flex items-center p-[1px] ${ props.errorTerms && "border-R300 border-2"}`}>
            <input
              type="checkbox"
              name="terms"
              defaultChecked={props.valueForTerms}
              className="accent-[#803785] w-[18px] h-[18px]"
              onChange={props.onSecondTermChange}
            />
          </div>
          <p className="text-sm text-N300 font-medium leading-[20px]">
            {" "}
            I hereby declare that i have read through the{" "}
            <span className="text-P300 cursor-pointer font-semibold hover:underline">
              <Link
                href={"T&C"}
                target="_blank"
              >
                Terms and Condition
              </Link>
            </span>{" "}
            of this Application
          </p>
        </li>
      </ul>
    </div>
  );
};

export default TermsAndConditions;
