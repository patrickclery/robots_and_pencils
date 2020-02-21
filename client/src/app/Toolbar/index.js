import React, {useState} from 'react'
import './index.css'
import RefreshIcon from "../RefreshIcon"
import Checkbox from "../Checkbox";

const Toolbar = ({refreshData}) => {
  const [checkedItems, setCheckedItems] = useState({
                                                     withRedditLinks:        false,
                                                     withSuccessfulLaunches: false,
                                                     withReuses:             false
                                                   });

  const handleChange = (event) => {
    setCheckedItems({
                      ...checkedItems,
                      [event.target.name]: event.target.checked
                    });
    refreshData
  };

  return (
    <div className="toolbar">
      <div className="toolbar-col toolbar__refresh-button">
        <RefreshIcon/>
      </div>
      <div className="toolbar-col toolbar__filter-checkbox">
        <Checkbox
          name="withSuccessfulLaunches"
          onChange={handleChange}/> Land Success
      </div>
      <div className="toolbar-col toolbar__filter-checkbox">
        <Checkbox
          name="withReuses"
          handleChange={handleChange}/> Reused

      </div>
      <div className="toolbar-col toolbar__filter-checkbox">
        <Checkbox
          name="withRedditLinks"
          handleChange={handleChange}/> With Reddit
      </div>
    </div>
  )
};

export default Toolbar