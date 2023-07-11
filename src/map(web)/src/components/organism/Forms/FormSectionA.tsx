import DropDownField from "@/components/atom/Customfields/DropDownField";
import TermsAndConditions from "@/components/atom/Customfields/TermsAndConditions";
import TextField from "@/components/atom/Customfields/TextField";
import { basicInfo } from "@/utils/types";
import { useForm } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";
import * as Yup from "yup"
import { ChangeEvent } from "react";

interface formSectionType {
  changeSection: () => void;
  passData: (data: basicInfo) => void;
}

const FormSectionA = (props: formSectionType) => {

  // setting form SectionA validation with Yup
  const validationSchema = Yup.object().shape({
    first_name: Yup.string().required("First Name is required"),
    last_name: Yup.string().required("Last Name is required"),
    email: Yup.string().required("Email is required"),
    education: Yup.number().required("Level of Education is required"),
    gender: Yup.number().required("Gender is required"),
    role: Yup.number().required("Role is required"),
    phone_number: Yup.string().required("Phone Number is required"),
    country: Yup.string().required("Country is required"),
    skills: Yup.string().required("Skills is required"),
    purpose: Yup.string().required("Purpose is required"),
  })

  // setting form SectionA validation with react-hook-form
  const {
    handleSubmit,
    setValue,
    getValues,
    formState: { errors },
  } = useForm<basicInfo>({
    resolver: yupResolver(validationSchema)
  });


  // Sends data to main form component and chnages form section
  const onSubmit = (data: basicInfo) => {
    props.passData(data)
    props.changeSection()
  }

  const handleSetValue =(value: string | number | ChangeEvent<HTMLInputElement>, name: any) => {
    setValue(name, value, { shouldValidate: true })
  }


  return (
    <form className="w-full flex flex-col gap-24"  onSubmit={handleSubmit(onSubmit)} encType="multipart/form-data" >
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <TextField
          label="First Name"
          onTextChange={(e) => handleSetValue(e.target.value, "first_name")}
          inputStyle=""
          containerStyle="lg:col-span-6 col-span-1"
          type="text"
          error={errors.first_name?.message}
        />
        <TextField
          label="Last Name"
          onTextChange={(e)=> handleSetValue(e.target.value, "last_name")}
          inputStyle=""
          containerStyle="lg:col-span-6 col-span-1"
          type="text"
          error={errors.last_name?.message}
        />
      </div>
      <div className="grid  lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <TextField
          label="Email"
          onTextChange={(e)=> handleSetValue(e.target.value, "email")}
          inputStyle=""
          containerStyle="col-span-12 col-span-1"
          type="email"
          error={errors.email?.message}
        />
      </div>
      <div className="grid  lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <DropDownField
          label="Level of Education"
          placeholder="Select level of education"
          textValue={undefined}
          options={[{label:"High School", value: 0}, {label: "Undergraduate", value:1}, {label: "Graduate", value:2}]}
          dropDownStyle=""
          onTextChange={(e)=> handleSetValue(e, "education")}
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
          options={[{label: "Male", value: 0}, {label: "Female", value: 1}]}
          dropDownStyle=""
          onTextChange={(e)=> handleSetValue(e, "gender")}
          inputStyle=""
          containerStyle="lg:col-span-6 col-span-1"
          error={errors.gender?.message}
        />
        <TextField
          label="Phone Number"
          onTextChange={(e)=> handleSetValue(e.target.value, "phone_number")}
          inputStyle=""
          containerStyle="lg:col-span-6 col-span-1"
          type="phone number"
          error={errors.phone_number?.message}
        />
      </div>
      <div className="grid  lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <DropDownField
          label="Skills"
          placeholder="Select skills"
          textValue={undefined}
          options={[{label: "Design", value: "Design"}, {label: "Programming", value:"Programming"}, 
          {label: "Analysis", value:"Analysis"}
        ]}
          dropDownStyle=""
          onTextChange={(e)=> handleSetValue(e, "skills")}
          inputStyle=""
          containerStyle="lg:col-span-8 col-span-1"
          error={errors.skills?.message}
        />
        <TextField
          label="Country"
          onTextChange={(e)=> handleSetValue(e.target.value, "country")}
          inputStyle=""
          containerStyle="lg:col-span-4 col-span-1"
          type="text"
          error={errors.country?.message}
        />
         <DropDownField
          label="Role"
          textValue={undefined}
          placeholder="Select role you are applying for"
          options={[{label: "Aspirant", value: 2}, {label: "Mentor", value: 1}]}
          dropDownStyle=""
          onTextChange={(e)=> handleSetValue(e, "role")}
          inputStyle=""
          containerStyle="lg:col-span-12 cols-span-1" 
          error={errors.role?.message}
        />
      </div>
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <DropDownField
          label="Purpose"
          textValue={undefined}
          placeholder="Select application purpose"
          options={[{label: "Learn", value: "Learn"}, {label: "Job offer", value:"Job offer"}, {label: "Upskill", value:"Upskill"}]}
          dropDownStyle=""
          onTextChange={(e)=> handleSetValue(e, "purpose")}
          inputStyle=""
          containerStyle="lg:col-span-12 cols-span-1" 
          error={errors.purpose?.message}
        />
      </div>
      <TermsAndConditions />
      <button className="w-full rounded-lg text-N00 font-semibold leading-[32px] bg-P300 py-12" type="submit"
      >
        Proceed
      </button>
    </form>
  );
};

export default FormSectionA;
