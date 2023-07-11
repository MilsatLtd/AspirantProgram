import { Link } from 'react-router-dom';

function Navbar({ showLinks}) {
  return (
    <nav className="bg-black py-4 px-4 w-full z-50">
        <div className="grid grid-cols-3 ">
          <div className="flex col-span-1 items-center">
            <Link to="/" className=" logo text-white font-bold text-2xl transition-colors duration-200 hover:text-gray-300 hover:rounded-full">MAP Admin</Link>
          </div>
          {
            showLinks && 
            <div className="flex col-span-1 justify-center items-center">
            <div className=" flex items-center gap-10 space-x-8" >
              <Link to="/cohorts" className="text-gray-100 hover:text-white px-3 py-2 rounded-md text-l font-medium">Cohorts</Link>
              <Link to="/tracks" className="text-gray-100 hover:text-white px-3 py-2 rounded-md text-l font-medium">Tracks</Link>
            </div>
          </div>
          }
        </div>
    </nav>
  );
}

export default Navbar;