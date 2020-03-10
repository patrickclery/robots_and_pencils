import React from 'react';
import Flight from './Flight';
import Header from './Header';
import './../src/App.css';
import RefreshIcon from './RefreshIcon';

class App extends React.Component {

  state = {
    flights: [],
    filters: {
      withRedditLinks:        0,
      withSuccessfulLaunches: 0,
      withReuses:             0
    }
  };

  // This takes the filters as params, then returns a JSON of the flights
  refreshFlights = filters => {
    let url = "http://localhost:3000/api/v1/flights?";
    url = `${url}with_reuses=${encodeURI(filters.withReuses)}&`;
    url = `${url}with_reddit=${encodeURI(filters.withRedditLinks)}&`;
    url = `${url}with_successful_launches=${encodeURI(filters.withSuccessfulLaunches)}`;

    fetch(url)
      .then(response => {
        return response.json();
      })
      .then(myJson => {
        this.setState({flights: myJson.data});
      });
  };


  handleChange = event => {
    let result = {[event.target.name]: (event.target.checked ? 1 : 0)};
    this.setState({filters: {...this.state.filters, ...result}});
    this.refreshFlights({...this.state.filters, ...result});
  };

  componentDidMount() {
    this.refreshFlights(this.state.filters);
  }

  render() {
    return (
      <div className="app--space-x">
        <div className="container">
          <div className="headline">
            SpaceX Launches
          </div>
          <div className="toolbar">
            <div className="toolbar-col--refresh">
              <RefreshIcon/>
            </div>
            <div className="toolbar-col--filter">
              <label id="withSuccessfulLaunches">
                <input type="checkbox" name="withSuccessfulLaunches" defaultChecked={false}
                       onChange={this.handleChange}/> Land Success
              </label>
            </div>

            <div className="toolbar-col--filter">
              <label id="withReuses">
                <input type="checkbox" name="withReuses" defaultChecked={false}
                       onChange={this.handleChange}/> Reused
              </label>
            </div>
            <div className="toolbar-col--filter">
              <label id="withRedditLinks">
                <input type="checkbox" name="withRedditLinks" defaultChecked={false}
                       onChange={this.handleChange}/> With Reddit
              </label>
            </div>
          </div>
          <div className="flights">
            <Header/>
            {this.state.flights.map((flight) =>
                           <Flight data={flight}
                                   key={flight.id}/>
            )}
          </div>
        </div>
      </div>
    )
  }
}

export default App;