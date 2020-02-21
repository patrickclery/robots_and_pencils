RSpec.describe Api::V1::FlightsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/flights").to route_to("flights#index")
    end
  end
end
