RSpec.describe Flight, type: :model do

  context 'associations' do
    it { should belong_to(:rocket).with_foreign_key(:rocket_id) }
  end

  context 'schema' do

    # Rather than use "flight_id" I decided to use "reference_number" ("reference" is also a reserved word) since a column like "flight_id" could be confusing and against "the Rails Way"
    it { should have_db_column(:reference_number).of_type(:integer).with_options(unique: true, null: false) }
    # details and failure details are consistently the exact same, so we'll only keep "details" and add launch_successful as a boolean.
    it { should have_db_column(:details).of_type(:text).with_options(null: false) }
    it { should have_db_column(:launch_successful).of_type(:boolean).with_options(null: false) }

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

end
