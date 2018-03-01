class Booking < ApplicationRecord
  has_many :guests
  belongs_to :apartment
  has_and_belongs_to_many :guests
  has_one :building, through: :apartment

  validates :apartment_id, :booking_start_date, :booking_end_date, :actual_monthly_rate, presence: true
  validates :guests, presence: true
  validates :booking_start_date, valid_booking_dates: true,
                                 unless: proc { |b| b.booking_start_date && b.booking_end_date && b.booking_start_date >= b.booking_end_date }
  validates :booking_start_date, booking_dates_in_order: true
  validates :booking_start_date, booking_must_be_a_valid_length: true,
                                 unless: proc { |b| b.booking_start_date && b.booking_end_date && b.booking_start_date >= b.booking_end_date }
  validates :actual_monthly_rate, numericality: true

  default_scope { order(booking_start_date: :desc) }
  scope :ends_after_today, -> { where("booking_end_date >= #{Date.today}") }

  BookingStatus::TYPES.each do |type|
    scope type.downcase, -> { where(status: type) }
  end

  BookingStatus::ShortestBookingDays = 28

  def booking_status_tense
    if booking_start_date > Date.today
      'future-booking'
    elsif booking_start_date <= Date.today && booking_end_date >= Date.today
      'current-booking'
    else
      'past-booking'
    end
  end
end
