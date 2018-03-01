class Apartment < ApplicationRecord
  has_many :bookings
  has_many :guests, through: :bookings
  has_and_belongs_to_many :amenities
  belongs_to :building

  scope :with_tenants_leaving_soon, -> {}
  scope :with_no_tenant_history, -> {}
  scope :with_no_current_bookings, -> {}

  validates :building_id, :apartment_type, :apt_number, :bathroom_count, :bedroom_count, :room_count, :monthly_rate, presence: true
  validates :bathroom_count, :bedroom_count, :room_count, :monthly_rate, numericality: true

  attr_accessor :date_available

  BEDROOM_COUNT = %w[0 1 2 3].freeze
  BATHROOM_COUNT = %w[1 1.5 2 2.5 3].freeze
  ROOM_COUNT = %w[1 2 3 4 5 6 7 8 9 10].freeze

  def name
    "#{apartment_type} #{apt_number}"
  end

  def date_available
    if bookings.select { |booking| booking.booking_end_date >= Date.today }.empty?
      'Now'
    else
      booking = bookings.order('booking_end_date desc').first
      booking.booking_end_date + 1.day
    end
  end

  def self.with_tenants_leaving_soon
    apartments = []
    apartments_with_tenants_leaving_soon = Apartment.left_outer_joins(:bookings).includes(:bookings).where("(booking_end_date >= '#{Date.today}' AND booking_end_date <= '#{Date.today + 3.months}')")
    # This block filters out those apartments with tenants leaving soon, that have another booking afterwards.
    apartments_with_tenants_leaving_soon.each do |apt|
      next if apt.bookings.select { |booking| booking.booking_start_date >= Date.today && booking.booking_end_date >= Date.today + 3.months }.present?
      booking = apt.bookings.order('booking_end_date desc').first
      apt.date_available = booking.booking_end_date + 1.day
      apartments << apt
    end
    apartments
  end

  def self.with_no_tenant_history
    apartments_with_no_tenant_history = Apartment.includes(:bookings).where(bookings: { id: nil })
    apartments_with_no_tenant_history.each { |apt| apt.date_available = 'Now' }
    apartments_with_no_tenant_history
  end

  def self.with_no_current_bookings
    # Get apartments with bookings with end dates before today.
    # Then select bookings with end dates after today. Any leftover apts will be empty
    apartments = []
    apartments_with_no_current_bookings = Apartment.left_outer_joins(:bookings).includes(:bookings).where("booking_end_date <= '#{Date.today}'")
    apartments_with_no_current_bookings.each do |apt|
      unless apt.bookings.select { |booking| booking.booking_end_date >= Date.today }.present?
        apt.date_available = 'Now'
        apartments << apt
      end
    end
    apartments
  end

  def self.needs_shopping
    # 1. An apartment can be currently rented and the tenant may be about to leave,
    #   but another tenant may be coming in right afterwards. That apartment should
    #   not be shopped.
    # 2. Apartments that have never had tenants need to be shopped.
    # 3. Apartments that have had tenants, but don't currently have one need to be shopped.
    # 4. Apartments with leases ending soon and no tenant scheduled afterwards
    #   need to be shopped.
    apartments_to_be_shopped = []
    apartments_to_be_shopped << Apartment.with_tenants_leaving_soon
    apartments_to_be_shopped << Apartment.with_no_tenant_history
    apartments_to_be_shopped << Apartment.with_no_current_bookings

    apartments_to_be_shopped.flatten
  end
end
