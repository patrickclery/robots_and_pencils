class FlightsController < ActionController::Base
  def index
    @flights = Flight.all
    render component: 'App', props: { flights: @flights }, layout: 'application', prerender: false
  end
end