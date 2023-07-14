import { createSlice } from "@reduxjs/toolkit";
import type { RootState } from "../store";
import type { PayloadAction } from "@reduxjs/toolkit";

//Set type for TrackSelect
export interface TrackSelect{
    name: string | null
    id: string | null
}

// set initial state value for selected Track
const initialState: TrackSelect ={ 
   name: null,
   id: null
}

export const trackSelectSlice = createSlice({
    name: "trackSelect",
    initialState,
    reducers: {
        setTrackSelect: (state, action: PayloadAction<{name: string, id: string}>) => {
            state.name = action.payload.name;
            state.id = action.payload.id;
        },
        clearTrackSelect: (state) => {
            state.name = null
            state.id = null
        }
    }
})


export const selectTrackSelect = (state: RootState)=> state.trackSelect;

export const {setTrackSelect, clearTrackSelect } =trackSelectSlice.actions;

export default trackSelectSlice.reducer;

