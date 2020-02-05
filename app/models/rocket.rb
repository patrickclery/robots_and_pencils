class Rocket < ApplicationRecord
  has_many :flights, dependent: :restrict_with_exception

  attribute :name, :string
  attribute :reference_number, :string
  attribute :type_name, :string

  validates :name, presence: true
  validates :reference_number, presence: true, uniqueness: true
  validates :type_name, presence: true
end
