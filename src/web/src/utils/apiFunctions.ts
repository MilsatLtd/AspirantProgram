import { enumObjects, currentCohort } from "./types";

// decalre array of months
const monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"];


// helps to format date from time-stamp to readable format
const formatDate = (date: string) => {
    const d = new Date(date);
    return `${d.getDate()}th ${monthNames[d.getMonth() + 1]} ${d.getFullYear()}`;

}

// helps to get the enum key from the enum value
const getEnumKeyByValue = (obj: enumObjects, value: number) => {
    return Object.keys(obj).find(key => obj[key] === value);
}

const getAllTracksDetails  = (cohort: currentCohort["data"]) => {
    let trackInfo: Array<{label: string, value: string}> = [];
    let cohortInfo: Array<{label: string, value: string}> = [];
    let applicationTimeline: {start_date: string, end_date: string} = {start_date: "", end_date: ""};
    cohort.map((item) => {
    const { tracks} = item;
    cohortInfo.push({label: item.name, value: item.cohort_id})
    item.status === 0 && (applicationTimeline = {start_date: item.apply_start_date, end_date: item.apply_end_date})
    trackInfo = tracks.map(track => ({label: track.name, value: track.track_id}))
   }
   )
   return {trackInfo ,cohortInfo, applicationTimeline};
}

const downloadFile = (filePath: string, fileName: string) => {
    // Fetch the file
    fetch(filePath,{
        headers: {
            'Content-Type': 'application/pdf', // Adjust based on the file type
          },
    })
      .then(response => response.blob())
      .then(blob => {
        // Create a link element
        const link = document.createElement('a');

        // Create a URL for the Blob and set it as the link's href
        link.href = window.URL.createObjectURL(blob);

        // Set the download attribute with the desired file name
        link.download = fileName;

        // Append the link to the document
        document.body.appendChild(link);

        // Trigger a click on the link to start the download
        link.click();

        // Remove the link from the document
        document.body.removeChild(link);
      });
  };




export { formatDate, getEnumKeyByValue, getAllTracksDetails, downloadFile };