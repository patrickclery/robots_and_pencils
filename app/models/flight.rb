class Flight < ApplicationRecord
  belongs_to :rocket, foreign_key: :rocket_id, required: true

  # These scopes are meant to be used to filter results for the API
  scope :with_reddit_links, -> {
    # Rails uses the WRONG operator (!=) with JSONB in PostgreSQL, and therefore raw SQL is necessary
    conditions = <<SQL
      links->>'reddit_campaign' <> '' OR
      links->>'reddit_launch' <> '' OR
      links->>'reddit_recovery' <> '' OR
      links->>'reddit_media' <> ''
SQL
    where(conditions)
  }
  scope :with_successful_launches, -> { where(launch_successful: true) }
  scope :with_reuses, -> { where(is_reused: true) }

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
