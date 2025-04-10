import { useEffect, useState, useRef } from "react";
import { useEffect, useState, useRef } from "react";
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

// Define types for dropdown options
interface DropdownOption {
  label: string;
  value: string | number;
}

// Define props interface for SearchableDropDown
interface SearchableDropDownProps {
  label: string;
  placeholder: string;
  options: DropdownOption[];
  onSelect: (option: DropdownOption) => void;
  error?: string;
  containerStyle?: string;
  value?: string | number;
  disabled?: boolean;
}

// Create a searchable dropdown component
const SearchableDropDown = ({
  label,
  placeholder,
  options,
  onSelect,
  error,
  containerStyle,
  value,
  disabled = false
}: SearchableDropDownProps) => {
  const [isOpen, setIsOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState("");
  const [filteredOptions, setFilteredOptions] = useState<DropdownOption[]>(options);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    // Filter options based on search term
    if (searchTerm) {
      const filtered = options.filter(option => 
        String(option.label).toLowerCase().includes(searchTerm.toLowerCase())
      );
      setFilteredOptions(filtered);
    } else {
      setFilteredOptions(options);
    }
  }, [searchTerm, options]);

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    };
    
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const handleSelect = (option: DropdownOption) => {
    onSelect(option);
    setIsOpen(false);
    setSearchTerm("");
  };

  const selectedLabel = value !== undefined ? 
    options.find(option => option.value === value)?.label : "";
  
  return (
    <div className={`flex flex-col gap-8 ${containerStyle}`} ref={dropdownRef}>
      <label className="text-N800 font-medium">{label}</label>
      <div className="relative">
        <div 
          className={`border border-N200 rounded-lg px-16 py-12 flex justify-between items-center ${disabled ? 'bg-gray-100 cursor-not-allowed' : 'cursor-pointer'}`}
          onClick={() => !disabled && setIsOpen(!isOpen)}
        >
          <span className={`${!selectedLabel ? 'text-gray-400' : 'text-black'}`}>
            {selectedLabel || placeholder}
          </span>
          <svg 
            className={`w-5 h-5 transition-transform ${isOpen ? 'transform rotate-180' : ''}`} 
            fill="none" 
            stroke="currentColor" 
            viewBox="0 0 24 24"
          >
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 9l-7 7-7-7" />
          </svg>
        </div>

        {isOpen && (
          <div className="absolute z-10 mt-1 w-full bg-white border border-gray-200 rounded-md shadow-lg max-h-60 overflow-auto">
            <div className="sticky top-0 bg-white p-2 border-b">
              <input
                type="text"
                className="w-full p-2 border border-gray-300 rounded"
                placeholder="Search..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                onClick={(e) => e.stopPropagation()}
              />
            </div>
            
            {filteredOptions.length > 0 ? (
              filteredOptions.map((option) => (
                <div
                  key={String(option.value)}
                  className="p-2 hover:bg-gray-100 cursor-pointer"
                  onClick={() => handleSelect(option)}
                >
                  {option.label}
                </div>
              ))
            ) : (
              <div className="p-2 text-gray-500">No results found</div>
            )}
          </div>
        )}
      </div>
      {error && <span className="text-red-500 text-sm mt-1">{error}</span>}
    </div>
  );
};

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
  const [isLgaDisabled, setIsLgaDisabled] = useState<boolean>(true);
  const [otherSourceText, setOtherSourceText] = useState<string>("");

  // Setting form SectionA validation with Yup
  const validationSchema = Yup.object().shape({
    first_name: Yup.string().required("First Name is required"),
    last_name: Yup.string().required("Last Name is required"),
    email: Yup.string().email("Invalid email format").required("Email is required"),
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

  // Setting form SectionA validation with react-hook-form
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
      setIsLgaDisabled(true);
    } else {
      setIsLgaDisabled(true);
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
        setIsLgaDisabled(false);
      } else {
        setAvailableLGAs([]);
        setIsLgaDisabled(true);
      }
      
      // Reset LGA when state changes
      setValue("lga", "");
    } else {
      setIsLgaDisabled(true);
    }
  }, [watchState, setValue]);

  // Handle the "Others" option for referral source
  useEffect(() => {
    setShowOtherSourceInput(watchReferralSource === "Others");
    
    // Reset other_source when referral_source changes away from "Others"
    if (watchReferralSource !== "Others") {
      setValue("other_source", "");
      setOtherSourceText("");
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

  const handleCountrySelect = (option: DropdownOption) => {
    handleSetValue(option.value, "country");
  };

  const handleStateSelect = (option: DropdownOption) => {
    handleSetValue(option.value, "state");
  };

  const handleLGASelect = (option: DropdownOption) => {
    handleSetValue(option.value, "lga");
  };

  const handleReferralSelect = (option: DropdownOption) => {
    handleSetValue(option.value, "referral_source");
  };

  const checkKeyDown = (e: React.KeyboardEvent) => {
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
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
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
        
        {/* Searchable Country Dropdown */}
        <SearchableDropDown
          label="Country"
          placeholder="Search Country"
          options={africanCountries}
          onSelect={handleCountrySelect}
          error={errors.country?.message}
          containerStyle="lg:col-span-4 col-span-1"
          value={watchCountry}
        />
      </div>
      
      {/* Nigeria-specific fields - State and LGA with searchable dropdowns */}
      {selectedCountry === "Nigeria" && (
        <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
          <SearchableDropDown
            label="State"
            placeholder="Search State"
            options={nigerianStatesOptions}
            onSelect={handleStateSelect}
            error={errors.state?.message}
            containerStyle="lg:col-span-6 col-span-1"
            value={watchState}
          />
          <SearchableDropDown
            label="LGA"
            placeholder={isLgaDisabled ? "Please select a state first" : "Search LGA"}
            options={availableLGAs}
            onSelect={handleLGASelect}
            error={errors.lga?.message}
            containerStyle="lg:col-span-6 col-span-1"
            value={watch("lga")}
            disabled={isLgaDisabled}
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
      
      {/* Referral source with improved "Others" handling */}
      <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
        <SearchableDropDown
          label="How did you hear about us?"
          placeholder="Select or search for an option"
          options={[
            { label: "Milsat Website", value: "Milsat Website" },
            { label: "Social Media Post", value: "Social Media Post" },
            { label: "Friends", value: "Friends" },
            { label: "3MTT Program", value: "3MTT Program" },
            { label: "Others", value: "Others" },
          ]}
          onSelect={handleReferralSelect}
          error={errors.referral_source?.message}
          containerStyle="lg:col-span-12 col-span-1"
          value={watchReferralSource}
        />
      </div>
      
      {showOtherSourceInput && (
  <div className="grid lg:grid-cols-12 grid-cols-1 gap-24 w-full">
    <TextField
      label="Please specify how you heard about us"
      onTextChange={(e) => {
        setOtherSourceText(e.target.value);
        handleSetValue(e.target.value, "other_source");
      }}
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