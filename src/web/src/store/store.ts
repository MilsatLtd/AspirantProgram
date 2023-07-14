import { configureStore } from '@reduxjs/toolkit';
import { applyApi } from './apiSlice/applyApi';
import trackSelectReducer from './slice/TrackSlice';
import allTracksReducer from './slice/AllTracks';
import { setupListeners } from '@reduxjs/toolkit/query/react'

const store = configureStore({
  reducer: {
    trackSelect: trackSelectReducer,
    allTracks: allTracksReducer,
    [applyApi.reducerPath]: applyApi.reducer
  },
    middleware: (getDefaultMiddleWare) => getDefaultMiddleWare({}).concat([applyApi.middleware])
});

export type AppDispatch  = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>

export default store;
setupListeners(store.dispatch); 