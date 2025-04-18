import DropDownField from "@/components/atom/Customfields/DropDownField";
import TextAreaField from "@/components/atom/Customfields/TextAreaField";
import FileUploader from "@/components/atom/Customfields/FileUploader";
import FileList from "@/components/atom/FileList";
import React, { useState, ChangeEvent, useEffect } from "react";
import { useAppSelector } from "@/store/hooks";
import { selectAllTracks } from "@/store/slice/AllTracks";
import { useForm } from "react-hook-form";
import * as Yup from "yup";
import { reasonInfo, allReasonInfo } from "@/utils/types";
import { yupResolver } from "@hookform/resolvers/yup";
import { useGetCurrentCohortQuery } from "@/store/apiSlice/applyApi";
import { getAllTracksDetails } from "@/utils/apiFunctions";

interface formSectionType {
  passData: (data: allReasonInfo) => void;
}

const FormSectionB = (props: formSectionType) => {
  const {
    data: currentChort,
    isSuccess: currentChortAvailable,
    isLoading,
  } = useGetCurrentCohortQuery(undefined);
  const [allChorts, setAllChorts] = useState([] as any);
  const [chortslist, setChortslist] = useState([] as any);
  const [tracks, setTracks] = useState([
    {
      label: "",
      value: "",
    },
  ]);
  // set file for file upload
  const [file, setFile] = useState<Array<File>>([]);

  // remove file from file upload
  const removeFile = (filename: string) => {
    setFile(file.filter((file) => file.name !== filename));
    if (file.length == 1) {
      setValue("file", undefined, { shouldValidate: true });
    }
  };

  // setting form SectionB validation with Yup
  const validationSchema = Yup.object().shape({
    track_id: Yup.string().required("Tracks is required"),
    file: Yup.mixed().required("File is required"),
    reason: Yup.string().required("Reason is required"),
  });

  // setting form SectionB validation with react-hook-form
  const {
    handleSubmit,
    setValue,
    formState: { errors },
  } = useForm<reasonInfo>({
    resolver: yupResolver(validationSchema),
  });

  // Sends and stores data in the local storage and initiates Page for the config file
  const onSubmit = (data: reasonInfo) => {
    delete data.cohort;
    console.log(data);
    props.passData({
      ...data,
      referral: "Website",
    });
  };

  // set value for react-hook-form
  const handleSetValue = (
    value:
      | string
      | number
      | File
      | ChangeEvent<HTMLInputElement>
      | ChangeEvent<HTMLTextAreaElement>,
    name: any
  ) => {
    setValue(name, value, { shouldValidate: true });
  };

  // set all chorts and tracks
  useEffect(() => {
    if (currentChortAvailable) {
      setAllChorts(currentChort);
      setTracks(getAllTracksDetails(currentChort).trackInfo);
      setChortslist(getAllTracksDetails(currentChort).cohortInfo);
    }
  }, [currentChort, currentChortAvailable, isLoading]);

  // filter tracks based on the cohort selected
  const filterTracks = (cohorts_id: string | number, allChorts: any) => {
    const filterTracks = allChorts.filter((cohort: any) => {
      if (cohorts_id === cohort.cohort_id) {
        return cohort;
      }
    });
    setTracks(getAllTracksDetails(filterTracks).trackInfo);
  };

  return (
    <form
      className="w-full flex flex-col gap-24"
      onSubmit={handleSubmit(onSubmit)}
      encType="multipart/form-data"
    >
      <DropDownField
        label="Cohort"
        placeholder="Select Cohorts"
        textValue={undefined}
        options={chortslist}
        dropDownStyle=""
        onTextChange={(e) => {
          handleSetValue(e, "cohort");
          filterTracks(e, allChorts);
        }}
        inputStyle=""
        emptyOptionsMessage="No Live Cohorts Available"
        containerStyle="col-span-12"
        error={errors.cohort?.message}
      />
      <DropDownField
        label="Tracks"
        placeholder="Select Track"
        textValue={undefined}
        options={tracks}
        disabled={tracks.length === 0}
        dropDownStyle=""
        onTextChange={(e) => handleSetValue(e, "track_id")}
        inputStyle=""
        containerStyle="col-span-12"
        error={errors.track_id?.message}
      />
      <FileUploader
        file={file}
        error={errors.file?.message}
        setFiles={setFile}
        addFile={(file) => {
          handleSetValue(file, "file");
        }}
      />
      <FileList allFiles={file} handleFileRemove={(file) => removeFile(file)} />
      <TextAreaField
        label="Reason for applying "
        placeholder="Let us know why you are applying for the program"
        inputStyle="h-[205px]"
        containerStyle="col-span-12"
        error={errors.reason?.message}
        onTextChange={(e) =>
          setValue("reason", e.target.value, { shouldValidate: true })
        }
        minLength={1}
      />
      <button className="w-full rounded-lg text-N00 font-semibold leading-[32px] bg-P300 py-12">
        Submit Application
      </button>
    </form>
  );
};

export default FormSectionB;
