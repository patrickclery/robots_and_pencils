import React, {useState} from 'react'
import RefreshIcon from '../components/RefreshIcon'
import Checkbox from '../components/Checkbox';

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
          handleChange={handleChange}/> Reused

      </div>
      <div className="toolbar-col toolbar-col--filter">
        <Checkbox
          name="withRedditLinks"
          handleChange={handleChange}/> With Reddit
      </div>
    </div>
  )
};

export default Toolbar