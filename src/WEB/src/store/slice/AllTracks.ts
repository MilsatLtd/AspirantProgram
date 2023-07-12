import { createSlice } from "@reduxjs/toolkit";
import type { RootState } from "../store";
import type { PayloadAction } from "@reduxjs/toolkit";

//Set type for TrackSelect
export interface allTracks{
    tracks: Array<{
        label: string| null,
        value: string| number | null
    }>,
    applicationTimeline: {
        start_date : string | null,
        end_date: string | null
    }    
}
const initialState: allTracks = {
    tracks : [
            {
                label: null,
                value: null
            }
        ],
    applicationTimeline: {
        start_date : null,
        end_date: null
    }
}
export const allTracksSlice = createSlice({
    name: "allTracks",
    initialState,
    reducers: {
        setAllTracks: (state, action: PayloadAction<{track: Array<{label: string, value: string | number}>}>) => {
            state.tracks = action.payload.track;
        }
    }
})

export const selectAllTracks = (state: RootState)=> state.allTracks;

export const {setAllTracks } =allTracksSlice.actions;

export default allTracksSlice.reducer;