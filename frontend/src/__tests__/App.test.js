import React from 'react';
import { render } from '@testing-library/react';
import App from '../components/App';

test('renders SpaceX hweadline', () => {
  const { getByText } = render(<App />);
  const linkElement = getByText(/SpaceX Launches/i);
  expect(linkElement).toBeInTheDocument();
});
