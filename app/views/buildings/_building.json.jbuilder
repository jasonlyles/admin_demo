json.extract! building, :id, :name, :description, :street_address, :city, :state_id, :zip, :manager_name, :phone_number, :notes, :created_at, :updated_at
json.url building_url(building, format: :json)
