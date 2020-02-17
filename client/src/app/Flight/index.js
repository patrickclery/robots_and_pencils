import React from 'react'
import './index.css'
import LinkIcon from '../LinkIcon'

function Flight({data: {attributes, links}}) {

  const {rocketName, rocketType, details, referenceNumber} = attributes;
  const {articleLink, redditCampaign} = links;

  return (
    <div className="flight__grid-row">
      <div className="flight__grid-cell flight__grid-cell--badge">&nbsp;</div>
      <div className="flight__grid-cell">{rocketName}</div>
      <div className="flight__grid-cell">{rocketType}</div>
      <div className="flight__grid-cell">2020-02-02</div>
      <div className="flight__grid-cell">{details}</div>
      <div className="flight__grid-cell flight__grid-cell--referenceNumber">{referenceNumber}</div>
      <div className="flight__grid-cell">
        {articleLink && <a href={articleLink}>
          <LinkIcon color="#00f"/>
        </a>}
        <a href="test">
          <LinkIcon color="#00f"/>
        </a>
        {redditCampaign && <a href={redditCampaign}>
          <LinkIcon color="#00f"/>
        </a>}
      </div>
    </div>
  )
}

export default Flight
