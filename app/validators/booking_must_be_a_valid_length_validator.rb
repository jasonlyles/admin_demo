class BookingMustBeAValidLengthValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, _value)
    if record.booking_start_date? && record.booking_end_date? && (record.booking_end_date - record.booking_start_date < BookingStatus::ShortestBookingDays)
      record.errors.add(:base,
                        :booking_too_short,
                        message: "Bookings must be at least #{BookingStatus::ShortestBookingDays} days")
    end
  end
end
