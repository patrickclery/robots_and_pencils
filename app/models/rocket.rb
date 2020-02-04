class Rocket < ApplicationRecord
  has_many :flights, dependent: :restrict_with_exception

  attribute :has_reused_core?, :boolean
  attribute :name, :string
  attribute :reference_number, :string
  attribute :type, :string

  validates :has_reused_core?, presence: true
  validates :name, presence: true
  validates :reference_number, presence: true, uniqueness: true
  validates :type, presence: true
end
