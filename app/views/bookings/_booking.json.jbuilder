json.extract! booking, :id, :apartment_id, :guest_id, :booking_status_id, :booking_start_date, :booking_end_date, :notes, :created_at, :updated_at
json.url booking_url(booking, format: :json)
