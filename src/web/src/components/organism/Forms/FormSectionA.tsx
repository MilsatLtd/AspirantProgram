import { useEffect, useState } from "react";
import DropDownField from "@/components/atom/Customfields/DropDownField";
import TermsAndConditions from "@/components/atom/Customfields/TermsAndConditions";
import TextField from "@/components/atom/Customfields/TextField";
import { basicInfo } from "@/utils/types";
import { useForm } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";
import * as Yup from "yup";
import { ChangeEvent } from "react";
import MultiTextField from "@/components/atom/Customfields/MultiTextField";
import { africanCountries, nigerianStatesAndLGAs } from "@/utils/data";

interface formSectionType {
  changeSection: () => void;
  passData: (data: basicInfo) => void;
  passEmail: (email:basicInfo["email"]) => void;
}

const FormSectionA = (props: formSectionType) => {
  const [selectedCountry, setSelectedCountry] = useState<string | undefined>(""); 
  const [selectedState, setSelectedState] = useState<string>("");
  const [availableLGAs, setAvailableLGAs] = useState<{label: string, value: string}[]>([]);
  const [showOtherSourceInput, setShowOtherSourceInput] = useState<boolean>(false);

  // setting form SectionA validation with Yup
  const validationSchema = Yup.object().shape({
    first_name: Yup.string().required("First Name is required"),
    last_name: Yup.string().required("Last Name is required"),
    email: Yup.string().required("Email is required"),
    education: Yup.number().required("Level of Education is required"),
    gender: Yup.number().required("Gender is required"),
    phone_number: Yup.string().required("Phone Number is required"),
    role: Yup.number().required("Role is required"),
    purpose: Yup.string().required("Purpose is required"),
    country: Yup.string().required("Country is required"),
    state: Yup.string().when("country", {
      is: "Nigeria",
      then: (schema) => schema.required("State is required"),
      otherwise: (schema) => schema.notRequired(),
    }),
    lga: Yup.string().when("country", {
      is: "Nigeria",
      then: (schema) => schema.required("LGA is required"),
      otherwise: (schema) => schema.notRequired(),
    }),
    skills: Yup.string().required("Skills are required"),
    referral_source: Yup.string().required("How you heard about us is required"),
    other_source: Yup.string().when("referral_source", {
      is: "Others",
      then: (schema) => schema.required("Please specify how you heard about us"),
      otherwise: (schema) => schema.notRequired(),
    }),
    terms: Yup.boolean().oneOf([true], "You must accept the Terms and Conditions"),
    accurate: Yup.boolean().oneOf([true], "You must accept the Terms and Conditions")
  });

  // setting form SectionA validation with react-hook-form
  const {
    handleSubmit,
    setValue,
    watch,
    formState: { errors },
  } = useForm<basicInfo>({
    resolver: yupResolver<Yup.AnyObjectSchema>(validationSchema),
    defaultValues: {
      first_name: '',
      last_name: '',
      terms: false,
      accurate: false,
    }
  });

  const watchCountry = watch("country");
  const watchState = watch("state");
  const watchRole = watch("role") as number | undefined;
  const watchReferralSource = watch("referral_source");

  // Update the selected country state when the country field changes
  useEffect(() => {
    setSelectedCountry(watchCountry || "");
    
    // Reset state and LGA values when country changes
    if (watchCountry !== "Nigeria") {
      setValue("state", "");
      setValue("lga", "");
    }
  }, [watchCountry, setValue]);

  // Update available LGAs when state changes
  useEffect(() => {
    if (watchState) {
      const stateData = nigerianStatesAndLGAs.find(state => state.name === watchState);
      if (stateData) {
        const lgaOptions = stateData.lgas.map(lga => ({
          label: lga,
          value: lga
        }));
        setAvailableLGAs(lgaOptions);
      } else {
        setAvailableLGAs([]);
      }
      
      // Reset LGA when state changes
      setValue("lga", "");
    }
  }, [watchState, setValue]);

  // Handle the "Others" option for referral source
  useEffect(() => {
    setShowOtherSourceInput(watchReferralSource === "Others");
    
    // Reset other_source when referral_source changes away from "Others"
    if (watchReferralSource !== "Others") {
      setValue("other_source", "");
    }
  }, [watchReferralSource, setValue]);

  // Sends data to main form component and changes form section
  const onSubmit = (data: basicInfo) => {
    if (data.purpose) {
      const formatedData = removeTerms(data);
      props.passData(formatedData);
      props.passEmail(data?.email);
    } else {
      data.purpose = "";
      const formatedData = removeTerms(data);
      props.passData(formatedData);
      props.passEmail(data?.email);
    }
    props.changeSection();
  };

  const removeTerms = (data: basicInfo) => {
    // Create a copy of data to avoid mutating the original
    const formattedData = { ...data };
    delete formattedData["terms"];
    delete formattedData["accurate"];
    return formattedData;
  };

  const handleSetValue = (
    value:
      | string
      | number
      | boolean
      | ChangeEvent<HTMLInputElement>,
    name: any
  ) => {
    setValue(name, value, { shouldValidate: true });
  };

  const checkKeyDown = (e: any) => {
    if (e.key === "Enter") e.preventDefault();
  };

  // Prepare Nigerian states dropdown options
  const nigerianStatesOptions = nigerianStatesAndLGAs.map(state => ({
    label: state.name,
    value: state.name
  }));

  return (
    <form
      className="w-full flex flex-col gap-24"
      onSubmit={handleSubmit(onSubmit)}
      onKeyDown={(e) => checkKeyDown(e)}
      encType="multipart/form-data"
    >
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <TextField
          label="First Name"
          onTextChange={(e) => handleSetValue(e.target.value, "first_name")}
          inputStyle=""
          placeholder="First Name"
          containerStyle="lg:col-span-6 col-span-1"
          type="text"
          error={errors.first_name?.message}
          minlength={1}
          maxlength={30}
        />
        <TextField
          label="Last Name"
          onTextChange={(e) => handleSetValue(e.target.value, "last_name")}
          inputStyle=""
          placeholder="Last name"
          containerStyle="lg:col-span-6 col-span-1"
          type="text"
          error={errors.last_name?.message}
          minlength={1}
          maxlength={30}
        />
      </div>
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <TextField
          label="Email"
          placeholder="Enter email"
          onTextChange={(e) => handleSetValue(e.target.value, "email")}
          inputStyle=""
          containerStyle="col-span-12 col-span-1"
          type="email"
          error={errors.email?.message}
        />
      </div>
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <DropDownField
          label="Level of Education"
          placeholder="Select level of education"
          textValue={undefined}
          options={[
            { label: "High School", value: 0 },
            { label: "Undergraduate", value: 1 },
            { label: "Graduate", value: 2 },
          ]}
          dropDownStyle=""
          onTextChange={(e) => handleSetValue(e, "education")}
          inputStyle=""
          containerStyle="col-span-12 col-span-1"
          error={errors.education?.message}
        />
      </div>
      <div className="grid  lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <DropDownField
          label="Gender"
          placeholder="Select gender"
          textValue={undefined}
          options={[
            { label: "Male", value: 0 },
            { label: "Female", value: 1 },
          ]}
          dropDownStyle=""
          onTextChange={(e) => handleSetValue(e, "gender")}
          inputStyle=""
          containerStyle="lg:col-span-6 col-span-1"
          error={errors.gender?.message}
        />
        <TextField
          label="Phone Number"
          onTextChange={(e) => handleSetValue(e.target.value, "phone_number")}
          placeholder="Add Phone number (e.g. 081 ** *** ***)"
          inputStyle=""
          containerStyle="lg:col-span-6 col-span-1"
          type="number"
          error={errors.phone_number?.message}
          minlength={1}
          maxlength={11}
        />
      </div>
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <MultiTextField
          label="Skills"
          placeholder="Add Skills"
          containerStyle="lg:col-span-8 col-span-1"
          error={errors.skills?.message}
          sendSkills={(skills: string) => handleSetValue(skills, "skills")}
        />
        <DropDownField
          label="Country"
          textValue={undefined}
          placeholder="Select Country"
          options={africanCountries}
          dropDownStyle="h-[20rem] overflow-auto"
          onTextChange={(e) => handleSetValue(e, "country")}
          inputStyle=""
          containerStyle="lg:col-span-4 col-span-1"
          error={errors.country?.message}
        />
      </div>
      
      {/* Nigeria-specific fields - State and LGA */}
      {selectedCountry === "Nigeria" && (
        <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
          <DropDownField
            label="State"
            textValue={undefined}
            placeholder="Select State"
            options={nigerianStatesOptions}
            dropDownStyle="h-[20rem] overflow-auto"
            onTextChange={(e) => handleSetValue(e, "state")}
            inputStyle=""
            containerStyle="lg:col-span-6 col-span-1"
            error={errors.state?.message}
          />
          <DropDownField
            label="LGA"
            textValue={undefined}
            placeholder="Select LGA"
            options={availableLGAs}
            dropDownStyle="h-[20rem] overflow-auto"
            onTextChange={(e) => handleSetValue(e, "lga")}
            inputStyle=""
            containerStyle="lg:col-span-6 col-span-1"
            error={errors.lga?.message}
          />
        </div>
      )}
      
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <DropDownField
          label="Role"
          textValue={undefined}
          placeholder="Select role you are applying for"
          options={[
            { label: "Aspirant", value: 2 },
            { label: "Mentor", value: 1 },
          ]}
          dropDownStyle=""
          onTextChange={(e) => {
            handleSetValue(e, "role");
            handleSetValue("", "purpose");
          }}
          inputStyle=""
          containerStyle="lg:col-span-12 col-span-1"
          error={errors.role?.message}
        />
      </div>
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        {watchRole && (
          <DropDownField
            label="Purpose"
            textValue={undefined}
            placeholder="Select application purpose"
            options={
              watchRole === 1
                ? [{ label: "Guidance", value: "Guidance" }]
                : [
                    { label: "Learn", value: "Learn" },
                    { label: "Job offer", value: "Job offer" },
                    { label: "Upskill", value: "Upskill" },
                  ]
            }
            dropDownStyle=""
            onTextChange={(e) => handleSetValue(e, "purpose")}
            inputStyle=""
            containerStyle="lg:col-span-12 cols-span-1"
            error={errors.purpose?.message}
          />
        )}
      </div>
      {/* New "How did you hear about us?" field */}
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <DropDownField
          label="How did you hear about us?"
          textValue={undefined}
          placeholder="Select an option"
          options={[
            { label: "Milsat Website", value: "Milsat Website" },
            { label: "Social Media Post", value: "Social Media Post" },
            { label: "Friends", value: "Friends" },
            { label: "3MTT Program", value: "3MTT Program" },
            { label: "Others", value: "Others" },
          ]}
          dropDownStyle=""
          onTextChange={(e) => handleSetValue(e, "referral_source")}
          inputStyle=""
          containerStyle="lg:col-span-12 col-span-1"
          error={errors.referral_source?.message}
        />
      </div>
      {/* Additional input field for "Others" option */}
      {showOtherSourceInput && (
        <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
          <TextField
            label="Please specify how you heard about us"
            onTextChange={(e) => handleSetValue(e.target.value, "other_source")}
            inputStyle=""
            placeholder="Enter source"
            containerStyle="lg:col-span-12 col-span-1"
            type="text"
            error={errors.other_source?.message}
          />
        </div>
      )}
      <TermsAndConditions
        onFirstTermChange={(e) => handleSetValue(e.target.checked, "accurate")}
        valueForAccurate={watch("accurate")}
        valueForTerms={watch("terms")}
        onSecondTermChange={(e) => handleSetValue(e.target.checked, "terms")}
        errorData={errors.accurate?.message}
        errorTerms={errors.terms?.message}
      />
      <button
        className="w-full rounded-lg text-N00 font-semibold leading-[32px] bg-P300 py-12"
        type="submit"
      >
        Proceed
      </button>
    </form>
  );
};

export default FormSectionA;