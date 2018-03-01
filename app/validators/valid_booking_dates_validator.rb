class ValidBookingDatesValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, _value)
    if record.apartment_id? && record.booking_start_date? && record.booking_end_date?
      record.apartment.bookings.each do |booking|
        next if record.id == booking.id
        overlapping_dates = ((booking.booking_start_date..booking.booking_end_date) & (record.booking_start_date..record.booking_end_date))
        next unless overlapping_dates.present?
        record.errors.add(:base,
                          :start_or_end_date_bad,
                          message: "The date range you selected overlaps an existing booking scheduled from #{booking.booking_start_date} to #{booking.booking_end_date}")
      end
    end
  end
end
