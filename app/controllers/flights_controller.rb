class FlightsController < ActionController::Base
  def index
    @flights = Flight.all
    render 'flights/index'
  end
end