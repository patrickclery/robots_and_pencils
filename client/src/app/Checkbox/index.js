import React from "react";

const Checkbox = ({name, checked = false, handleChange}) => {
  return (
    <label>
      <input type="checkbox" name={name} defaultChecked={checked} onChange={handleChange}/>
    </label>
  )
};

export default Checkbox