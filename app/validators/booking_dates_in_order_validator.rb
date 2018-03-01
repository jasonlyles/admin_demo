class BookingDatesInOrderValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, _value)
    if record.booking_start_date? && record.booking_end_date? && record.booking_start_date > record.booking_end_date
      record.errors.add(:base,
                        :dates_out_of_order,
                        message: 'The date range you selected is out of order.')
    end
  end
end
