import { useState } from "react"
import { useMutation } from "@tanstack/react-query";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import Navbar from "./Navbar";
import Auth from "./api/login";

function Login () {


  const auth = useMutation((credentials) => Auth(credentials), {
    onSuccess: (res) => {
      localStorage.setItem('token', res.access)
      localStorage.setItem('refresh', res.refresh)
      navigate('/cohorts')
      setIsAuth(true)
    },
    onError: (err) => {
      setIsAuth(false)
    }
  })

  const navigate = useNavigate()

  const [credentials, setCredentials] = useState({
    email: '',
    password: ''
  })
  const [isAuth, setIsAuth] = useState(true)

  const handleChange = (e) => {
    setCredentials({
      ...credentials,
      [e.target.id]: e.target.value
    })
  }

  const handleSubmit = (e) => {
    e.preventDefault();
    auth.mutate(credentials)
  }

  return (
    <div className="flex flex-col h-screen">
    <Navbar showLinks={false} />
    <div className='w-screen flex-grow flex items-center justify-center'> 
        <form className="grid grid-row-2 gap-8 w-[30%]" >
          {
            !isAuth ? <div className="row-span-1 flex flex-col items-center">
              <p className="text-red-500">Invalid Credentials</p>
              </div> : null
          }
            <div className='row-span-1 flex flex-col gap-2'>
                <label htmlFor="email" className="text-lg font-medium">Email</label>
                <input type="email" id="email"  className="rounded-md border-[1px] outline-2 p-2 border-black "
                onChange={handleChange}
                />
            </div>
            <div className='row-span-1 flex flex-col gap-2'>
                <label htmlFor="password" className="text-lg font-medium">Password</label>
                <input type="password" id="password"  className="rounded-md border-[1px] outline-2 p-2  border-black"
                onChange={handleChange}
                />
            </div>
            {/* <Link to="/cohorts" className="w-full"> */}
            <button onClick={handleSubmit}
            className="bg-black hover:opacity-90 text-white w-full font-bold py-2 px-4 rounded"
            >Login</button>
            {/* </Link> */}
            
        </form>
    </div>
    </div>
    
  )
}

export default Login