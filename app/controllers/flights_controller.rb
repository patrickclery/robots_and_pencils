class FlightsController < ApplicationController

  def index
    @flights = Flight.all
    @flights = @flights.filter_reddit_links if params[:with_reddit_links].present?
    @flights = @flights.filter_successful_launches if params[:with_successful_launches].present?
    @flights = @flights.filter_reuses if params[:with_reuses].present?

    render json: FlightSerializer.new(@flights)
  end

  private

  def filter_params
    params.permit(:with_reddit_links)
    params.permit(:with_successful_launches)
    params.permit(:with_reuses)
  end
end
