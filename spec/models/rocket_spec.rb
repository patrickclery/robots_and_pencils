RSpec.describe Rocket, type: :model do

  context 'associations' do
    # Don't allow a rocket to be destroyed if any flights depend on it
    it { should have_many(:flights).dependent(:restrict_with_exception) }
  end

  context 'schema' do
    it { should have_db_column(:has_reused_core).of_type(:boolean).with_options(null: false) }
    it { should have_db_column(:name).of_type(:string).with_options(null: false) }
    # Rather than use "rocket_id" I decided to use "reference_number" ("reference" is also a reserved word) since a column like "rocket_id" could be confusing and against "the Rails Way"
    it { should have_db_column(:reference_number).of_type(:string).with_options(null: false, unique: true) }
    it { should have_db_column(:type).of_type(:string).with_options(null: false) }
    # If any of the "cores" are reused, mark it as reused
  end

end
