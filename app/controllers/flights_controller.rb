class FlightsController < ApplicationController

  def index
    @flights = Flight.all
    @flights = @flights.with_reddit_links if filter_params[:with_reddit_links].present?
    @flights = @flights.with_successful_launches if filter_params[:with_successful_launches].present?
    @flights = @flights.with_reuses if filter_params[:with_reuses].present?

    render json: @flights
  end

  private

  def filter_params
    params.permit(:with_reddit_links)
    params.permit(:with_successful_launches)
    params.permit(:with_reuses)
  end
end
