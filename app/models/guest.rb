class Guest < ApplicationRecord
  has_and_belongs_to_many :bookings

  # Normalize before validation
  phony_normalize :phone_number, default_country_code: 'US'

  validates :gender, :first_name, :last_name, :email, :phone_number, presence: true
  validates :email, email: true
  validates_plausible_phone :phone_number
  validates :date_of_birth,
            date: { after: proc { Date.new(1900, 1, 1) },
                    before: proc { Date.today - 25.years } }

  before_validation :create_full_name

  def create_full_name
    self.full_name = first_name + ' ' + last_name
  end

  def tenant_status
    if bookings.empty? || (bookings.select { |booking| booking.booking_start_date < Date.today && booking.booking_end_date > Date.today }.empty? && bookings.select { |booking| booking.booking_start_date > Date.today }.present?)
      'Future'
    elsif bookings.select { |booking| booking.booking_start_date < Date.today && booking.booking_end_date > Date.today }.empty? && bookings.select { |booking| booking.booking_start_date < Date.today && booking.booking_end_date < Date.today }.present?
      'Past'
    elsif bookings.select { |booking| booking.booking_start_date < Date.today && booking.booking_end_date > Date.today }.present?
      'Current'
    else
      'Unknown'
    end
  end
end
