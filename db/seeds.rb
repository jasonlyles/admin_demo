AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Amenity.create([
                 { name: 'Extra Large Closet' },
                 { name: 'In-unit Washer and Dryer' },
                 { name: 'Washer & Dryer Connections' },
                 { name: 'Air Conditioning' },
                 { name: 'Pets Allowed' },
                 { name: 'Smoking Allowed' },
                 { name: 'Non-Smoking' },
                 { name: 'Furnished' },
                 { name: 'Some Utilities Included' },
                 { name: 'All Utilities Included' },
                 { name: 'Balcony' },
                 { name: 'Cable Ready' }
               ])

BuildingAmenity.create([
                         { name: 'Pet Friendly' },
                         { name: 'Garage' },
                         { name: 'Swimming Pool' },
                         { name: 'High Speed Internet Access' },
                         { name: 'Fitness Center' },
                         { name: 'Laundry Facility' },
                         { name: 'Covered Parking' },
                         { name: 'Gated Access' },
                         { name: 'Wireless Internet Access' },
                         { name: 'Access to Public Transportation' }
                       ])

State.create([
               { name: 'Alabama', abbreviation: 'AL' },
               { name: 'Alaska', abbreviation: 'AK' },
               { name: 'Arizona', abbreviation: 'AZ' },
               { name: 'Arkansas', abbreviation: 'AR' },
               { name: 'California', abbreviation: 'CA' },
               { name: 'Colorado', abbreviation: 'CO' },
               { name: 'Connecticut', abbreviation: 'CT' },
               { name: 'Delaware', abbreviation: 'DE' },
               { name: 'District of Columbia', abbreviation: 'DC' },
               { name: 'Florida', abbreviation: 'FL' },
               { name: 'Georgia', abbreviation: 'GA' },
               { name: 'Hawaii', abbreviation: 'HI' },
               { name: 'Idaho', abbreviation: 'ID' },
               { name: 'Illinois', abbreviation: 'IL' },
               { name: 'Indiana', abbreviation: 'IN' },
               { name: 'Iowa', abbreviation: 'IA' },
               { name: 'Kansas', abbreviation: 'KS' },
               { name: 'Kentucky', abbreviation: 'KY' },
               { name: 'Louisiana', abbreviation: 'LA' },
               { name: 'Maine', abbreviation: 'ME' },
               { name: 'Maryland', abbreviation: 'MD' },
               { name: 'Massachusetts', abbreviation: 'MA' },
               { name: 'Michigan', abbreviation: 'MI' },
               { name: 'Minnesota', abbreviation: 'MN' },
               { name: 'Mississippi', abbreviation: 'MS' },
               { name: 'Missouri', abbreviation: 'MO' },
               { name: 'Montana', abbreviation: 'MT' },
               { name: 'Nebraska', abbreviation: 'NE' },
               { name: 'Nevada', abbreviation: 'NV' },
               { name: 'New Hampshire', abbreviation: 'NH' },
               { name: 'New Jersey', abbreviation: 'NJ' },
               { name: 'New Mexico', abbreviation: 'NM' },
               { name: 'New York', abbreviation: 'NY' },
               { name: 'North Carolina', abbreviation: 'NC' },
               { name: 'North Dakota', abbreviation: 'ND' },
               { name: 'Ohio', abbreviation: 'OH' },
               { name: 'Oklahoma', abbreviation: 'OK' },
               { name: 'Oregon', abbreviation: 'OR' },
               { name: 'Pennsylvania', abbreviation: 'PA' },
               { name: 'Rhode Island', abbreviation: 'RI' },
               { name: 'South Carolina', abbreviation: 'SC' },
               { name: 'South Dakota', abbreviation: 'SD' },
               { name: 'Tennessee', abbreviation: 'TN' },
               { name: 'Texas', abbreviation: 'TX' },
               { name: 'Utah', abbreviation: 'UT' },
               { name: 'Vermont', abbreviation: 'VT' },
               { name: 'Virginia', abbreviation: 'VA' },
               { name: 'Washington', abbreviation: 'WA' },
               { name: 'West Virginia', abbreviation: 'WV' },
               { name: 'Wisconsin', abbreviation: 'WI' },
               { name: 'Wyoming', abbreviation: 'WY' }
             ])

Building.create([
                  { name: 'Building One at The Plaza', description: 'A great building located next to The Plaza', street_address: '10630 Red Lion Place', city: 'Richmond', state_id: 47, zip: '23225', manager_name: 'Bob McDonald', phone_number: '(804) 567-9032' },
                  { name: 'Building Four on the River', description: 'A great building located next to the River', street_address: '106 Broad Street', city: 'Atlanta', state_id: 11, zip: '30348', manager_name: 'Roger Dodger', phone_number: '(338) 567-9032' }
                ])

Apartment.create([
                   { building_id: Building.first.id, apartment_type: 'Studio', apt_number: '32A', bathroom_count: 1, bedroom_count: 0, room_count: 2, monthly_rate: 500 },
                   { building_id: Building.first.id, apartment_type: 'One Bedroom', apt_number: '16F', bathroom_count: 1, bedroom_count: 1, room_count: 3, monthly_rate: 700 },
                   { building_id: Building.first.id, apartment_type: 'Two Bedroom', apt_number: '4G', bathroom_count: 1.5, bedroom_count: 2, room_count: 6, monthly_rate: 900 },
                   { building_id: Building.last.id, apartment_type: 'Efficiency', apt_number: '2C', bathroom_count: 1, bedroom_count: 0, room_count: 2, monthly_rate: 450 },
                   { building_id: Building.last.id, apartment_type: 'Efficiency', apt_number: '3A', bathroom_count: 1, bedroom_count: 0, room_count: 2, monthly_rate: 450 },
                   { building_id: Building.last.id, apartment_type: 'Studio', apt_number: '5D', bathroom_count: 1, bedroom_count: 0, room_count: 2, monthly_rate: 550 },
                   { building_id: Building.last.id, apartment_type: 'One Bedroom', apt_number: '6A', bathroom_count: 1.5, bedroom_count: 1, room_count: 5, monthly_rate: 675 }
                 ])

# Create some guests
guest1 = Guest.create(gender: 'Female', first_name: 'Jennifer', last_name: 'Wilcox', email: 'jwilcox@yahoo.com', phone_number: '804 867-5309', date_of_birth: '1983-04-01')
guest2 = Guest.create(gender: 'Male', first_name: 'Roger', last_name: 'Wilcox', email: 'rwilcox@yahoo.com', phone_number: '804 678-5309', date_of_birth: '1981-04-08')
guest3 = Guest.create(gender: 'Male', first_name: 'Bill', last_name: 'McDougal', email: 'thedoogs@yahoo.com', phone_number: '778 867-5309', date_of_birth: '1991-07-01')
guest4 = Guest.create(gender: 'Female', first_name: 'Karen', last_name: 'Larsson', email: 'klars@yahoo.com', phone_number: '668 867-5309', date_of_birth: '1973-04-01')

# Create some bookings
booking1 = Booking.new(apartment_id: Apartment.first.id, booking_start_date: Date.today - 30.days, booking_end_date: Date.today + 60.days, status: 'Reserved', actual_monthly_rate: 500)
booking1.guests << guest4
booking1.save!

booking2 = Booking.new(apartment_id: Apartment.first.id, booking_start_date: Date.today - 120.days, booking_end_date: Date.today - 60.days, status: 'Expired', actual_monthly_rate: 450)
booking2.guests << guest3
booking2.save!

booking3 = Booking.new(apartment_id: Apartment.last.id, booking_start_date: Date.today + 5.days, booking_end_date: Date.today + 65.days, status: 'Pending', actual_monthly_rate: 675)
booking3.guests << [guest1, guest2]
booking3.save!

booking4 = Booking.new(apartment_id: Apartment.first.id, booking_start_date: Date.today + 61.days, booking_end_date: Date.today + 180.days, status: 'Reserved', actual_monthly_rate: 475)
booking4.guests << guest2
booking4.save!

# Create some Building amenities
building1 = Building.first
building1.building_amenities << BuildingAmenity.find([3, 5, 7])
building1.save

building2 = Building.last
building2.building_amenities << BuildingAmenity.find([1, 2, 8])
building2.save

# Create some apartment amenities
apartments = Apartment.all
amenities = Amenity.all

apartments.each do |apt|
  5.times do
    amenity = amenities.sample
    apt.amenities << amenity unless apt.amenities.include?(amenity)
    apt.save
  end
end
