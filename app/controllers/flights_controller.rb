class FlightsController < ActionController::Base
  def index
    @flights = Flight.all
    render :index, layout: 'application', prerender: true
  end
end