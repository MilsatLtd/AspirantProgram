import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
// import { RootState } from "../store";
import { applicationResponseType, allApplicationList, currentCohort } from "../dataTypes";
import { API_ENDPOINT } from "../../../config/index";


export const applyApi = createApi({
    reducerPath: "applyApi",
    baseQuery: fetchBaseQuery({
    baseUrl: API_ENDPOINT
  }),

  tagTypes: ['Admin'],
  endpoints: (builder) => ({    
    getCurrentCohort: builder.query<currentCohort["data"],undefined>({
        query: () => {
            return {
              url: "/applications/cohorts/open",
              method: "get",
              providesTags: ['Apply']
            };
          },
    }),
    getAllApplications: builder.query<allApplicationList, undefined>({
        query: () => {
            return {
              url: "/applications/",
              method: "get",
              providesTags: ['Apply']
            };
          },
    }),
    apply: builder.mutation({
      query: (body: FormData) => {
          return {
            url: "/cohorts/apply",
            method: "post",
            // headers: {
            //   'content-type': 'multipart/form-data'
            // },
            body,
            providesTags: ['Apply']
          };
        },
      }),
    sendEmail: builder.mutation({
      query: (body: { email:string, subject:string, message:string}) => {
          return {
            url: "/email_async_test",
            method: "post",
            body,
            providesTags: ['apply-email']
          };
        },
      })
  }),
})

export const {
   useGetCurrentCohortQuery, 
   useGetAllApplicationsQuery,
   useApplyMutation,
   useSendEmailMutation
  } = applyApi