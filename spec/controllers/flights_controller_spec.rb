RSpec.describe FlightsController, type: :controller do

  let(:valid_session) { {} }

  describe "GET #index" do
    # Note, semantics here are important: "before" must precede "subject!"
    before do
      allow(Flight).to receive(:all).and_return(flight_stack)
    end

    subject! { get :index, session: valid_session }

    # Create a list of 12 flights
    let!(:flight_stack) { create_list(:flight, 12) }

    it { should be_successful }
    it { expect(response.content_type).to eq("application/json; charset=utf-8") }
    it { expect(JSON.parse(response.body)).to be_an Array }
    it { expect(JSON.parse(response.body).first.keys).to include("id", "reference_number", "details", "launch_successful", "is_reused", "local_launched_at", "links", "rocket_id") }
    it { expect(JSON.parse(response.body).size).to eq 12 }
  end

end
