import React, {useState, useEffect} from 'react';
import Flight from './Flight';
import Header from './Header';
import '../scss/styles.css';
import RefreshIcon from "./RefreshIcon";

function App() {

  const [flights, setFlights] = useState([]);
  const [filters, setFilters] = useState({
                                           withRedditLinks:        0,
                                           withSuccessfulLaunches: 0,
                                           withReuses:             0
                                         });

  // This takes the filters as params, then returns a JSON of the flights
  const refreshFlights = () => {
    let url = "http://localhost:3000/flights?";
    url = `${url}with_reuses=${encodeURI(filters.withReuses)}&`;
    url = `${url}with_reddit=${encodeURI(filters.withRedditLinks)}&`;
    url = `${url}with_successful_launches=${encodeURI(filters.withSuccessfulLaunches)}`;

    fetch(url)
      .then(response => {
        return response.json();
      })
      .then(myJson => {
        setFlights(myJson.data);
      });
  };


  const handleChange = (event) => {
    let result = {[event.target.name]: (event.target.checked ? 1 : 0)};
    setFilters({...filters, ...result});
  };

  useEffect(() => {
    refreshFlights(filters)
  }, [filters]);

  return (
    <div className="app--space-x">
      <div className="container">
        <div className="headline">
          SpaceX Launches
        </div>
        <div className="toolbar">
          <div className="toolbar__refresh-button" onClick={refreshFlights}>
            <RefreshIcon/>
          </div>
          <div className="toolbar__filter-checkbox">
            <label id="withSuccessfulLaunches">
              <input type="checkbox" name="withSuccessfulLaunches" defaultChecked={false}
                     onChange={handleChange}/> Land Success
            </label>
          </div>

          <div className="toolbar__filter-checkbox">
            <label id="withReuses">
              <input type="checkbox" name="withReuses" defaultChecked={false}
                     onChange={handleChange}/> Reused
            </label>
          </div>
          <div className="toolbar__filter-checkbox">
            <label id="withRedditLinks">
            <input type="checkbox" name="withRedditLinks" defaultChecked={false}
                   onChange={handleChange}/> With Reddit
            </label>
          </div>
        </div>
        <div className="flights">
          <Header/>
          {flights.map((flight) =>
                         <Flight data={flight}
                                 key={flight.id}/>
          )}
        </div>
      </div>
    </div>
  )
}

export default App;