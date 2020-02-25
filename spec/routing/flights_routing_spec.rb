RSpec.describe Api::V1::FlightsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/flights").to route_to("api/v1/flights#index")
    end
  end
end
