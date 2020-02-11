class Rocket < ApplicationRecord
  has_many :flights, dependent: :restrict_with_exception

  attribute :name, :string
  attribute :reference_number, :string
  attribute :type_name, :string

  # These aliases are so Flight can delegate easily when creating the JSON that is passed to the front-end
  alias_attribute :rocket_name, :name
  alias_attribute :rocket_type, :type_name

  validates :name, presence: true
  validates :reference_number, presence: true, uniqueness: true
  validates :type_name, presence: true
end
