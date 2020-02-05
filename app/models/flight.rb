class Flight < ApplicationRecord
  belongs_to :rocket, foreign_key: :rocket_id, required: true

  # Type-cast all the values to make validation easier
  attribute :details, :string
  attribute :is_reused, :boolean
  attribute :launch_successful, :boolean
  attribute :links, :json
  attribute :local_launched_at, :datetime
  attribute :reference_number, :integer

  # All values are required, and "reference_number" must be unique
  validates :details, presence: false
  validates :is_reused, default: false, inclusion: [true,false]
  validates :launch_successful, inclusion: [true,false]
  validates :links, presence: true
  validates :local_launched_at, presence: true
  validates :reference_number, presence: true, uniqueness: true
  validates :rocket, presence: true

end
