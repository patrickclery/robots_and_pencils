import React from 'react';
import { shallow } from 'enzyme';
import App from './App';

describe('app component', () => {
  it('contains a header with "SpaceX Flights"', () => {
    const app = shallow(<App/>);
    expect(app.containsMatchingElement("SpaceX Flights")).toEqual(true);
  });
});