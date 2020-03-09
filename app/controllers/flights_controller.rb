class FlightsController < ActionController::Base
  def index
    @flights = Flight.all
    render component: 'App'
  end
end