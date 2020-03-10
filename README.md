![RSpec](https://github.com/patrickclery/spacex/workflows/Ruby/badge.svg)

![screenshot](https://user-images.githubusercontent.com/25733135/74923494-bfb09d00-5385-11ea-815f-969f222a24a2.jpg)

## Instructions to install/run the app

#### Clone the project:
`git clone https://github.com/patrickclery/spacex.git`

#### Install the gems
`cd spacex && bundle install && yarn install`

#### Create and populate the database with seed data
`rake db:create db:schema:load db:seed`

#### Start the rails server
`foreman start -f Procfile.dev`

#### Open the app in your browser
Go to http://localhost:3000/flights

---

## Robots & Pencils Fullstack Developer Assessment

---

### BACKEND
- Create a database, and run a migration using the JSON from the “seed-data.json” file included in this directory as seed data.
    - The provided JSON is data that needs to be imported into your database, but you only need to import the data that is relevant to the frontend experience
    - However you decide to implement your database, it's required you ensure it's easily installable for those reviewing your submission (e.g. an install script, setup documentation, shareable instance, etc.)
- Create your own API to deliver that data from your database to the frontend for display in the table
    - The response data should at all times correspond to the filtering status in the UI
- Unit testing (with integration tests as an optional bonus)
- Hosting: Deploy the project to a free location of your choosing and share the live URL back to Robots & Pencils. Alternatively you may utilize local virtualization with a technology like docker, provided you supply clear instructions on how to spin it up. The key is to provide an easy way to validate the solution.

---

### FRONTEND
- At the very least, browser support for Chrome
- Implement the visual design as closely as possible. Where there might be questions, use your best judgement to implement what you think was initially desired, and jot down your decisions for future discussions with Robots & Pencils
- The following functionality should be implemented:
    - Data Refresh
        - Clicking the REFRESH icon should re-fetch the data set from the API according to the selected filters, and update the list
    - Filtering
        - This should be done within the backend API, and be defined as:
            - “Land Success” if that property is truthy on the data object
            - “Reused” if the data object indicates any reused elements
            - “With Reddit” if the data object contains any non-null property of the convention “reddit_[something]”
            - If any filters are checked, only data that matches all checked filters should appear
            - Link Outs
                - If the data object contains a URL to an external article, clicking the LINK icon on the corresponding row should open that article in a new tab
            - Scrolling
                - The cosmic background should remain fixed as the user scrolls the page

##### A note on timing:

We fully understand that the ability to commit time to this will vary by person and situation, so there is no fixed minimum or maximum time, just use your best judgement. We try to be conscious of your availability when we send this out, and we can be flexible in adjustments if needed and communicated in advance. We’re evaluating your code, not your turnaround time. At the end of the day, this is just a data point in our decision making process, and it gives us visibility into you as a candidate that we would struggle to get any other way. All we ask is that you put your best foot forward and are prepared to speak to your solution, your process, and your mindset in our follow-up discussions.
