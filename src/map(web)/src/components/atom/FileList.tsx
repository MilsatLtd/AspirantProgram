import Image from 'next/image';
import FileIcon from '../../Assets/file.svg'
import FileCloseIcon from '../../Assets/fileClose.svg'

interface FileListType {
    allFiles: File[];
    handleFileRemove: (file: string) => void;
}

const FileList = (props: FileListType) => {
    return (
        <ul className='flex flex-col gap-24'>
            {
                props.allFiles &&
                props.allFiles.map((file, index) => {
                    return (
                        <li key={index}
                            className='p-16 border-[1.5px] flex rounded-md justify-between gap-16'
                        > <div className='flex-1 flex-col gap-[17px]'>
                                <div className='flex gap-20 '>
                                    <Image src={FileIcon} alt="file-icon" />
                                    <span className='text-[16px] font-medium leading-[28px]'>{file.name}</span>
                                </div>
                                <div className="flex items-center gap-8">
                                    <div className="w-full bg-P50 rounded-full h-[5px] transition">
                                    <div
                                            className={`bg-P300 h-[5px] rounded-full w-[100%]`}
                                        ></div>
                                    </div>
                                    <span className="text-N300 text-sm leading-[24px] font-medium">
                                        {100}%
                                    </span>
                                </div>
                            </div>
                            <div className='cursor-pointer' onClick={()=>props.handleFileRemove(file.name)}>
                                <Image src={FileCloseIcon} alt="file-close-icon" />
                            </div>

                        </li>
                    )
                })
            }
        </ul>
    )
}

export default FileList