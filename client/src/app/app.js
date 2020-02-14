import React, {Component} from 'react';
import Flight from './Flight';
import '../scss/styles.css';

class App extends Component {
  state = {flights: []};

  componentDidMount() {
    this.refreshData();
  }

  refreshData() {
    fetch("http://localhost:3000/flights")
      .then(response => {
        return response.json();
      })
      .then(myJson => {
        this.setState({flights: myJson.data});
      });
  }

  render() {
    const {flights} = this.state;
    return (
      <div className="app--space-theme">
        <div className="heading--h1">
          SpaceX Launches
        </div>
        <div className="flights__grid">
          <div className="flights__headers">
            <div className="flights__headers__th">Badges</div>
            <div className="flights__headers__th">Rocket Name</div>
            <div className="flights__headers__th">Rocket Type</div>
            <div className="flights__headers__th">Launch Date</div>
            <div className="flights__headers__th">Details</div>
            <div className="flights__headers__th">ID</div>
            <div className="flights__headers__th">Article</div>
          </div>
          {flights.map((flight) =>
                         <Flight data={flight}
                                 key={flight.id}/>
          )}
          <div className="flights__line">&nbsp;</div>
        </div>
      </div>
    )
  }
}

export default App
