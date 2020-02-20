import React from 'react'
import LinkIcon from '../LinkIcon'
import placeholder from './images/placeholder.png'

function Flight({data: {attributes, links}}) {

  const {rocketName, rocketType, formattedDate, details, referenceNumber} = attributes;
  const {missionPatchSmall, articleLink, redditCampaign, redditLaunch, redditRecovery, redditMedia} = links;

  return (
    <div className="flight-row">
      <div className="flight-cell">
        <img src={missionPatchSmall ? missionPatchSmall : placeholder} width="50" height="50" />
      </div>
      <div className="flight-cell">{rocketName}</div>
      <div className="flight-cell">{rocketType}</div>
      <div className="flight-cell">{formattedDate}</div>
      <div className="flight-cell">{details}</div>
      <div className="flight-cell flight-cell--referenceNumber">{referenceNumber}</div>
      <div className="flight-cell">
        {articleLink && <a href={articleLink}>
          <LinkIcon color="#00f"/>
        </a>}
        {redditCampaign && <a href={redditCampaign}>
          <LinkIcon color="#f00"/>
        </a>}
        {redditLaunch && <a href={redditLaunch}>
          <LinkIcon color="#f00"/>
        </a>}
        {redditRecovery && <a href={redditRecovery}>
          <LinkIcon color="#f00"/>
        </a>}
        {redditMedia && <a href={redditMedia}>
          <LinkIcon color="#f00"/>
        </a>}
      </div>
    </div>
  )
}

export default Flight
