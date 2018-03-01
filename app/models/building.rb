class Building < ApplicationRecord
  has_many :apartments
  belongs_to :state
  has_and_belongs_to_many :building_amenities
  has_many :bookings, through: :apartments

  # Normalize before validation
  phony_normalize :phone_number, default_country_code: 'US'

  validates :name, :street_address, :city, :state_id, :zip, :manager_name, :phone_number, presence: true
  validates_plausible_phone :phone_number
end
