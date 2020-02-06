RSpec.describe FlightsController, type: :controller do

  describe "GET #index" do

    context "without filters" do
      # Create a list of 12 flights
      let!(:flights) { create_list(:flight, 3) }
      subject {
        allow(Flight).to receive(:all).and_return(flights)
        get :index
      }

      it { should be_successful }
      it { expect(subject.content_type).to eq("application/json; charset=utf-8") }
      it { expect(JSON.parse(subject.body)).to be_an Array }
      it { expect(JSON.parse(subject.body).first.keys).to include("id", "reference_number", "details", "launch_successful", "is_reused", "local_launched_at", "links", "rocket_id") }
      it { expect(JSON.parse(subject.body).size).to eq 3 }

    end

    context "filter by reddit links" do
      subject { get :index, params: { with_reddit_links: 1 } }

      # Create a list of 12 flights
      let!(:flights) { create_list(:flight, 3) }
      let!(:flights_with_reddit) { create_list(:flight, 2, :with_reddit_links) }

      # Ensure the proper filters and ONLY the proper filters are called
      it {
        expect(Flight).to receive(:filter_reddit_links)
        expect(Flight).not_to receive(:filter_successful_launches)
        expect(Flight).not_to receive(:filter_reuses)
        subject
      }

      it { expect(subject.content_type).to eq("application/json; charset=utf-8") }
      it { expect(JSON.parse(subject.body)).to be_an Array }
      it { expect(JSON.parse(subject.body).size).to eq 2 }
    end

    context "filter by successful launches" do
      subject { get :index, params: { with_successful_launches: 1 } }

      # Create a list of 12 flights
      let!(:flights) { create_list(:flight, 7, launch_successful: true) }
      let!(:flights_failed) { create_list(:flight, 3, launch_successful: false) }

      # Ensure the proper filters and ONLY the proper filters are called
      it {
        expect(Flight).not_to receive(:filter_reddit_links)
        expect(Flight).to receive(:filter_successful_launches)
        expect(Flight).not_to receive(:filter_reuses)
        subject
      }

      it { expect(subject.content_type).to eq("application/json; charset=utf-8") }
      it { expect(JSON.parse(subject.body)).to be_an Array }
      it { expect(JSON.parse(subject.body).size).to eq 7 }
    end

    context "filter by reuses" do
      subject { get :index, params: { with_reuses: 1 } }

      # Create a list of 12 flights
      let!(:flights) { create_list(:flight, 2, is_reused: false) }
      let!(:flights_reused) { create_list(:flight, 6, is_reused: true) }

      # Ensure the proper filters and ONLY the proper filters are called
      it {
        expect(Flight).not_to receive(:filter_reddit_links)
        expect(Flight).not_to receive(:filter_successful_launches)
        expect(Flight).to receive(:filter_reuses)
        subject
      }

      it { expect(subject.content_type).to eq("application/json; charset=utf-8") }
      it { expect(JSON.parse(subject.body)).to be_an Array }
      it { expect(JSON.parse(subject.body).size).to eq 6 }
    end
  end

end
