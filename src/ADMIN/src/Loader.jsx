function Loader( {css1, css2}) {
    return (
        <div className={" " + css1}  >
            <div className={" loader " + css2}>
            </div>
        </div>
    );
}

export default Loader;