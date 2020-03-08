class FlightsController < ApplicationController
  def index
    @flights = Flight.all
    render component: 'App', props: { flights: @flights }
  end
end