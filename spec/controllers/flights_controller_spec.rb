RSpec.describe FlightsController, type: :controller do

  describe "GET #index" do
    # Create a list of 12 flights
    let!(:flights) { create_list(:flight, 3, :with_reddit_links) }

    context "without filters" do
      # Stub it to not actually use the database
      subject(:get_flights_lists) {
        allow(Flight).to receive(:all).and_return(flights)
        get :index
      }
      # Ensure the basic request worked
      it { should be_successful }
      it { expect(subject.content_type).to eq("application/json; charset=utf-8") }

      # Check if the collection is an array
      # NOTE: skipped checking the actual collection here it would be pointless when using a stub
      describe "The JSON collection" do
        subject(:json_payload) { JSON.parse(get_flights_lists.body)["data"] }
        it { should be_an Array }
      end

      describe "a sample flight from the JSON data" do
        subject(:json_flight) { JSON.parse(get_flights_lists.body)["data"].sample }
        it { expect(subject["attributes"].keys).to contain_exactly "details",
                                                                   "id",
                                                                   "isReused",
                                                                   "launchSuccessful",
                                                                   "launchedAt",
                                                                   "referenceNumber",
                                                                   "rocketName",
                                                                   "rocketType" }
        it { expect(subject["links"].keys).to contain_exactly "articleLink",
                                                              "missionPatch",
                                                              "missionPatchSmall",
                                                              "redditCampaign",
                                                              "redditLaunch",
                                                              "redditMedia",
                                                              "redditRecovery" }
      end

    end

    context "filter by reddit links" do
      subject {
        # Stub this to return filtered flights only - this is tested in the unit test for Flight
        allow(Flight).to receive(:filter_reddit_links).and_return(flights_with_reddit)
        get :index, params: { with_reddit_links: 1 }
        JSON.parse(response.body)["data"]
      }

      # Create a list of 12 flights
      let!(:flights_with_reddit) { create_list(:flight, 2, :with_reddit_links) }

      # Ensure the proper filters and ONLY the proper filters are called
      it {
        expect(Flight).to receive(:filter_reddit_links)
        expect(Flight).not_to receive(:filter_successful_launches)
        expect(Flight).not_to receive(:filter_reuses)
        subject
      }

      it { expect(subject).to be_an Array }
      it { expect(subject.size).to eq 2 }
    end

    context "filter by successful launches" do

      subject {
        # Stub this to return filtered flights only - this is tested in the unit test for Flight
        allow(Flight).to receive(:filter_successful_launches).and_return(flights_launched)
        get :index, params: { with_successful_launches: 1 }
        JSON.parse(response.body)["data"]
      }

      let!(:flights_launched) { create_list(:flight, 3, launch_successful: true) }

      # Ensure the proper filters and ONLY the proper filters are called
      it {
        expect(Flight).not_to receive(:filter_reddit_links)
        expect(Flight).to receive(:filter_successful_launches)
        expect(Flight).not_to receive(:filter_reuses)
        subject
      }

      it { expect(subject).to be_an Array }
      it { expect(subject.size).to eq 3 }
    end

    context "filter by reuses" do
      subject {
        # Stub this to return filtered flights only - this is tested in the unit test for Flight
        allow(Flight).to receive(:filter_reuses).and_return(flights_reused)
        get :index, params: { with_reuses: 1 }
        JSON.parse(response.body)["data"]
      }

      let!(:flights_reused) { create_list(:flight, 3, is_reused: true) }

      # Ensure the proper filters and ONLY the proper filters are called
      it {
        expect(Flight).not_to receive(:filter_reddit_links)
        expect(Flight).not_to receive(:filter_successful_launches)
        expect(Flight).to receive(:filter_reuses)
        subject
      }

      it { expect(subject).to be_an Array }
      it { expect(subject.size).to eq 3 }
    end
  end

end
