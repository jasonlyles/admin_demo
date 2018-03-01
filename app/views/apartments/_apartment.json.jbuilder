json.extract! apartment, :id, :building_id, :apartment_type_id, :apt_number, :bathroom_count, :bedroom_count, :room_count, :notes, :created_at, :updated_at
json.url apartment_url(apartment, format: :json)
