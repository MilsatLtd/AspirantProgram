// function Loader(big, {css1, css2}) {
//     return (
//         <div className={" " + css1}  >
//             <div className={" loader " + css2}>
//             </div>
//         </div>
//     );
// }

function Loader({css1, css2, big=false}) {
    return (
        <div className={" " + css1}  >
            <div className={" loader " + (big ? "loader-big" : css2)}>
            </div>
        </div>
    );
}

export default Loader;