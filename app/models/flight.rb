class Flight < ApplicationRecord
  belongs_to :rocket, foreign_key: :rocket_id

  # Type-cast all the values to make validation easier
  attribute :details, :string
  attribute :launch_successful, :boolean
  attribute :links, :json
  attribute :local_launched_at, :datetime
  attribute :reference_number, :integer

  # All values are required, and "reference_number" must be unique
  validates :details, presence: true
  validates :launch_successful, presence: true
  validates :links, presence: true
  validates :local_launched_at, presence: true
  validates :reference_number, presence: true, uniqueness: true

end
