import React, {useState} from 'react'
import './index.css'
import RefreshIcon from "../RefreshIcon"

const Checkbox = ({name, checked = false, onChange}) => {
  return (
    <input type="checkbox" name={name} checked={checked} onChange={onChange}/>
  )
};

const Toolbar = () => {

  const [checkedItems, setCheckedItems] = useState({
                                                     withRedditLinks:        false,
                                                     withSuccessfulLaunches: false,
                                                     withReuses:             false
                                                   });

  return (
    <div className="toolbar">
      <div className="toolbar-col toolbar-col--refresh">
        <RefreshIcon/>
      </div>
      <div className="toolbar-col toolbar-col--filter">
        <Checkbox
          name="withSuccessfulLaunches"
          onChange={handleChange}/> Land Success
      </div>
      <div className="toolbar-col toolbar-col--filter">
        <Checkbox
          name="withReuses"
          onChange={handleChange}/> Reused

      </div>
      <div className="toolbar-col toolbar-col--filter">
        <Checkbox
          name="withRedditLinks"
          onChange={handleChange}/> With Reddit
      </div>
    </div>
  )
};

export default Toolbar