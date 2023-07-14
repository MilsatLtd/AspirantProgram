import Enums from './enum.js';

const getEnumKeyByValue = (obj, value)  => {
  return Object.keys(obj).find(key => obj[key] === value);
}

const monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"];

const formatDate = (date) => {
  const d = new Date(date);
  return `${d.getDate()}th ${monthNames[d.getMonth()]} ${d.getFullYear()}`;

}
const formatDateToISO = (date, time) => {
// Combine the date and time strings into a single string in ISO 8601 format
const dateTimeString = `${date}T${time}`;
const localDateTime = new Date(dateTimeString);
const options = { timeZone: 'Africa/Lagos' };
const cetDateTimeString  = localDateTime.toLocaleString('en-US', options);
// Create a new Date object from the combined string
const isoDateTimeString = new Date(cetDateTimeString ).toISOString();
console.log(isoDateTimeString)

// Convert the Date object to a date-time string in ISO 8601 format
return isoDateTimeString

}

const formatCourseDetails = (courseDetails) => {
  const keyToRemove = 'id'
  const newArray = courseDetails.map(({[keyToRemove]: _, ...rest}) => rest);
  return newArray
}

const formatCohort = (cohort) => {
      cohort.status = getEnumKeyByValue(Enums.COHORT_STATUS, cohort.status)

      cohort.start_date = formatDate(cohort.start_date)

      cohort.end_date = formatDate(cohort.end_date)

      cohort.apply_start_date = formatDate(cohort.apply_start_date)

      cohort.apply_end_date = formatDate(cohort.apply_end_date)
      return cohort;
}

const utils = {
  getEnumKeyByValue,
  formatDate,
  formatCohort,
  formatDateToISO,
  formatCourseDetails
}

export default utils;