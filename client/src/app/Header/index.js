import React from 'react'
import './index.css'

function Header() {

  return (
    <div className="flights__headers">
      <div className="flights__headers__th">Badges</div>
      <div className="flights__headers__th">Rocket Name</div>
      <div className="flights__headers__th">Rocket Type</div>
      <div className="flights__headers__th">Launch Date</div>
      <div className="flights__headers__th">Details</div>
      <div className="flights__headers__th">ID</div>
      <div className="flights__headers__th">Article</div>
    </div>
  )
}

export default Header