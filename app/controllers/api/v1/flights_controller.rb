module Api
  module V1
    class Api::V1::FlightsController < ApplicationController

      def index
        @flights = Flight.includes(:rocket).order(launched_at: :desc).all
        @flights = @flights.filter_reddit_links if params[:with_reddit] == "1"
        @flights = @flights.filter_successful_launches if params[:with_successful_launches] == "1"
        @flights = @flights.filter_reuses if params[:with_reuses] == "1"

        render json: FlightSerializer.new(@flights)
      end

      private

      def filter_params
        params.permit(:with_reddit_links)
        params.permit(:with_successful_launches)
        params.permit(:with_reuses)
      end
    end
  end
end