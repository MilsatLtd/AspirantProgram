import { useState } from "react";
import Image from "next/image";
import Logo from "../../Assets/logo.svg";
import MenuIcon from "../../Assets/menu.svg";
import CloseIcon from "../../Assets/close.svg";
import NavLink from "../atom/NavLink";
import Link from "next/link";
import router from "next/router";
import { WEB_APP_ROUTE } from "../../../config";
interface headerType {
  showNavLinks: boolean;
  showApplyButton: boolean;
}

const Header = (props: headerType) => {
  const [showMenu, setShowMenu] = useState(false);
  return (
    <div>
      <div className="lg:px-96 md:px-48 overflow-x-clip scrollbar-hide px-16 py-24 grid lg:grid-cols-12 grid-cols-2 items-center w-full z-50 relative">
        <div className="flex justify-start lg:col-span-4 col-span-1">
          <Link href="/">
            <Image src={Logo} alt="MAP-logo" className="h-auto w-auto" />
          </Link>
        </div>
        <div className="col-span-8 hidden lg:grid lg:grid-cols-2 items-center lg:justify-between  ">
          {props.showNavLinks ? <NavLink /> : null}
          {props.showApplyButton ? (
            <div
              className={`col-span-1 ${
                props.showNavLinks === false && "col-span-4"
              } flex gap-16 cursor-pointer justify-end`}
            >
              <button
                className="py-12 px-40 bg-P300 hover:bg-P200  text-N00 rounded-lg font-semibold"
                onClick={() => {
                  router.push("/apply");
                }}
              >
                Apply
              </button>
              <Link
                href={WEB_APP_ROUTE ? WEB_APP_ROUTE : "/login"}
                className="py-12 px-40 bg-P300 hover:bg-P200  text-N00 rounded-lg font-semibold"
                target="_blank"
              >
                Login
              </Link>
            </div>
          ) : null}
        </div>

        <div
          className={`absolute z-30 rounded-2xl shadow-lg lg:hidden top-[90px] lg:w-full w-[85%] transition-all delay-100 ease-in-out ${
            showMenu ? "right-[8px]  mx-auto left-0 " : "right-[-90%]"
          }  px-16 py-[31px] h-max gap-11 bottom-0 bg-N00 flex flex-col justify-between`}
        >
          {props.showNavLinks ? <NavLink /> : null}
          {props.showApplyButton ? (
            <div className={`col-span-4 flex flex-col cursor-pointer gap-16 items-center justify-center`}>
              <button
                className="py-12 px-40 bg-P300 hover:bg-P200  text-N00 rounded-lg font-semibold w-full"
                onClick={() => {
                  router.push("/apply");
                }}
              >
                Apply
              </button>
              <Link
                href={WEB_APP_ROUTE ? WEB_APP_ROUTE : ""}
                className="py-12 px-40 bg-P300 hover:bg-P200 w-full text-center  text-N00 rounded-lg font-semibold"
                target="_blank"
              >
                Login
              </Link>
            </div>
          ) : null}
        </div>
        <div className="col-span-1 lg:hidden flex justify-end cursor-pointer transition-all delay-150 ease-in-out">
          {showMenu ? (
            <Image
              src={CloseIcon}
              alt="close-icon"
              className="h-auto w-auto"
              onClick={() => setShowMenu(!showMenu)}
            />
          ) : (
            <Image
              src={MenuIcon}
              alt="menu-icon"
              className="h-auto w-auto"
              onClick={() => setShowMenu(!showMenu)}
            />
          )}
        </div>
      </div>
    </div>
  );
};

export default Header;
