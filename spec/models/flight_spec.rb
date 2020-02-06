RSpec.describe Flight, type: :model do

  context 'associations' do
    it { should belong_to(:rocket).with_foreign_key(:rocket_id) }

    # These are scopes that are used by the controller to filter the list
    describe ".with_reddit_links" do
      subject { Flight.with_reddit_links.all }
      let!(:flights) { create_list(:flight, 3) }
      let!(:flights_with_reddit_links) { create_list(:flight, 5, :with_reddit_links) }

      it { expect(Flight).to respond_to(:with_reddit_links) }
      it { should contain_exactly(*flights_with_reddit_links) }
    end

    describe ".with_successful_launches" do
      subject { Flight.with_successful_launches.all }
      let!(:flights) { create_list(:flight, 4, launch_successful: false) }
      let!(:flights_with_successful_launches) { create_list(:flight, 6, launch_successful: true) }

      it { expect(Flight).to respond_to(:with_successful_launches) }
      it { should contain_exactly(*flights_with_successful_launches) }
    end

    describe ".with_reuses" do
      subject { Flight.with_reuses.all }
      let!(:flights) { create_list(:flight, 2, is_reused: false) }
      let!(:flights_with_reuses) { create_list(:flight, 4, is_reused: true) }

      it { expect(Flight).to respond_to(:with_reuses) }
      it { should contain_exactly(*flights_with_reuses) }
    end

  end

  context 'schema' do

    # Rather than use "flight_id" I decided to use "reference_number" ("reference" is also a reserved word) since a column like "flight_id" could be confusing and against "the Rails Way"
    it { should have_db_column(:reference_number).of_type(:integer).with_options(unique: true, null: false) }
    # details and failure details are consistently the exact same, so we'll only keep "details" and add launch_successful as a boolean.
    it { should have_db_column(:details).of_type(:text).with_options(null: true) }
    it { should have_db_column(:launch_successful).of_type(:boolean).with_options(null: false) }
    it { should have_db_column(:is_reused).of_type(:boolean).with_options(null: false) }
    # We only need the local launch time, and from that we can infer UTC time
    it { should have_db_column(:local_launched_at).of_type(:datetime).with_options(null: false) }

    # "links" includes:
    #  - mission_patch* (this is where "a" is represented)
    #  - reddit_*
    #  - article_link
    it { should have_db_column(:links).of_type(:json).with_options(null: false) }

    # References
    it { should have_db_column(:rocket_id).of_type(:integer).with_options(null: false) }

  end

  context 'validations' do
    subject { create(:flight) }
    it { should validate_inclusion_of(:is_reused).in_array([true,false]).presence }
    it { should validate_inclusion_of(:launch_successful).in_array([true,false]).presence }
    it { should validate_presence_of(:links) }
    it { should validate_presence_of(:local_launched_at) }
    it { should validate_presence_of(:rocket) }
    it { should validate_uniqueness_of(:reference_number).presence }
    it { should_not validate_presence_of(:details) }
  end

end
