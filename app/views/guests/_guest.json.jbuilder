json.extract! guest, :id, :gender_id, :first_name, :last_name, :date_of_birth, :notes, :created_at, :updated_at
json.url guest_url(guest, format: :json)
