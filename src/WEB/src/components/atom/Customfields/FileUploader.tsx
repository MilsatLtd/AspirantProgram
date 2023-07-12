import React, { useState } from "react";

interface FileUploaderType {
  file: File[];
  setFiles: React.Dispatch<React.SetStateAction<File[]>>;
  addFile: (file: File) => void;
  error: string | undefined;
}

const FileUploader = ({file , error, setFiles, addFile}:FileUploaderType) => {
  const [uploadProgress, setUploadProgress] = useState<number | null>(null);

  function handleFileChange(event: React.ChangeEvent<HTMLInputElement>): void {
    let selectedFile = event.target.files?.[0];
    if (selectedFile && selectedFile.size <= 2 * 1024 * 1024 && file.length < 1) {
      setFiles([...file, selectedFile]);
      addFile(selectedFile);
    } else if(selectedFile && selectedFile.size <= 2 * 1024 * 1024 && file.length >= 1){
      alert("You can only upload 1 file");
      selectedFile= undefined;
    }else {
      alert("Please select a file that is 2MB or smaller.");
      selectedFile= undefined;
    }

  }

  return (
    <div className="flex flex-col gap-8">
      <label className="text-[16px] leading-[28px] text-N400 lg:font-semibold font-medium">
        Attach Documents (Resume, Certificates, Accomplishments - 1 limit)
      </label>
      <div className={`flex relative border-dashed border-[1px]  ${error ? " border-R300": "border-N75"} h-[124px] rounded-lg`}>
        <div className="text-N400 flex items-center  justify-center w-full h-full ">
          <input
            type="file"
            title=""
            className="opacity-0 relative z-10 w-full h-full cursor-pointer"
            onChange={handleFileChange}
            multiple
          />
          <div className="absolute z-5 flex flex-col gap-10">
            <p className="lg:text-[16px] text-m-sm font-medium text-N400 ">
              <span className="text-P300 lg:leading-[28px] leading-[24px] lg:font-semibold font-medium">
                Click here
              </span>{" "}
              to upload or <span className="font-semibold">Drag and Drop</span>
            </p>
            <p className="font-medium text-sm leading-[20px] text-center">
              Maximum file size{" "}
              <span className=" text-[16px] font-semibold leading-[28px]">
                2 MB
              </span>
            </p>
          </div>
        </div>
      </div>
      <span className="h-[2px] text-R300 text-sm">{error &&error}</span>
    </div>
  );
};

export default FileUploader;
