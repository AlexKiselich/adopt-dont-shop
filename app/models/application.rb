class Application < ApplicationRecord
  validates :applicant, presence: true
  validates :address, presence: true
  validates :description, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets
end
