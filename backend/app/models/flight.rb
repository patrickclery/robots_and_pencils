class Flight < ApplicationRecord
  belongs_to :rocket, foreign_key: :rocket_id, required: true
  delegate :rocket_name, to: :rocket
  delegate :rocket_type, to: :rocket
  order launched_at: :desc

  # These scopes are meant to be used to filter results for the API
  # NOTE: "with_" is a reserved keyword by ActiveRecord when combining scopes,
  # so I opted for "filter_" instead of "with_"
  scope :filter_reddit_links, -> {
    # Rails uses the WRONG operator (!=) with JSONB in PostgreSQL, and therefore raw SQL is necessary
    conditions = <<SQL
      ("links"->>'reddit_campaign'::text <> '' OR
      "links"->>'reddit_launch'::text <> '' OR
      "links"->>'reddit_recovery'::text <> '' OR
      "links"->>'reddit_media'::text <> '')
SQL
    where(conditions)
  }
  scope :filter_successful_launches, -> { where(launch_successful: true) }
  scope :filter_reuses, -> { where(is_reused: true) }

  # Type-cast all the values to make validation easier
  attribute :details, :string
  attribute :is_reused, :boolean
  attribute :launch_successful, :boolean
  attribute :links, :json
  attribute :launched_at, :datetime
  attribute :local_utc_offset, :string
  attribute :reference_number, :integer

  # All values are required, and "reference_number" must be unique
  validates :details, presence: false
  validates :is_reused, default: false, inclusion: [true, false]
  validates :launch_successful, inclusion: [true, false]
  validates :links, presence: true
  validates :launched_at, presence: true
  validates :local_utc_offset, presence: true
  validates :reference_number, presence: true, uniqueness: true
  validates :rocket, presence: true

end
