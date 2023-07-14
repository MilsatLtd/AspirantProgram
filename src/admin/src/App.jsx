import './App.css'
import Login from './Login'
import Cohort from './Cohort'
import Track from './Track'
import { HashRouter , Route, Routes} from 'react-router-dom'
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import CohortDetails from './CohortDetails';
import TrackDetails from './TrackDetails'
// import { useRouteMatch } from 'react-router-dom';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: Infinity,
      cacheTime: Infinity,
    },
  },
});

function App() {

  return (
    <HashRouter>
    <QueryClientProvider client={queryClient}>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/cohorts" element={<Cohort />} />
        <Route path="/cohorts/:cohort_id" element={<CohortDetails />} />
        <Route path="/tracks/" element={<Track></Track>}> </Route>
        <Route path="/tracks/:track_id" element={<TrackDetails />} />
      </Routes>
    </QueryClientProvider>
    </HashRouter>
  )
}

export default App
