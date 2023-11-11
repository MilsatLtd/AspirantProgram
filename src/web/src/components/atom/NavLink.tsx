import { routes } from "@/utils/data";
import { useRouter } from "next/router";

const NavLink = () => {
  const router = useRouter()
  const { navLinks } = routes;
  return (
    <ul className="col-span-1 flex lg:flex-row flex-col items-center justify-center gap-32 transition-all delay-150">
      {navLinks.map((nav, index) => {
        return (
          <li
            key={index}
            onClick={()=>{router.push(nav.link)}}
            className={` text-center ${
              router.asPath === nav.link
                ? "text-P300 font-semibold cursor-pointer w-[66px]"
                : " text-N300 font-medium text-base transition delay-150 w-[66px] ease-in-out leading-32 cursor-pointer"
            }`}
          >
            {nav.name}
          </li>
        );
      })}
    </ul>
  );
};

export default NavLink;
