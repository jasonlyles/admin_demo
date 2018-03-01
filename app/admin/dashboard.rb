ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_upper' do
      columns do
        column do
          panel 'Demo Site Info', class: 'site-info' do
            para 'Welcome to this apartment booking demo app. Note that this is only a demo app, not
            a complete working application that takes into account all the nuances
            of booking apartments. As such, it is not 100% complete, 100% perfect or ready to be
            used to actually book apartments. Anything you see can be extended, tweaked, modified,
            fixed or rearranged by the developer. This is simply a demo site I built while exploring an admin
            framework that was new to me. Have a look around, try creating and modifying records,
            and get a feel for the app. This site design is responsive, so view it on your tablet,
            phone and lapatop, or resize your browser on your laptop to see it in action. Also,
            the batch action to send welcome emails to guests doesn\'t actually send emails, it\'s just
            an example. Thanks!'
          end
        end
      end
      columns do
        column do
          panel 'Newest Guests' do
            table_for Guest.order('created_at desc').last(10) do
              column('Name') { |guest| link_to(guest.full_name, admin_guest_path(guest)) }
              column :phone_number
              column :email
              column 'Registered', :created_at
            end
          end
        end
        column do
          panel 'Latest Bookings' do
            table_for Booking.order('booking_start_date desc').last(10) do
              column('Apartment') { |booking| link_to(booking.building.name, admin_building_path(booking.building)) + ' / ' + link_to(booking.apartment.name, admin_apartment_path(booking.apartment)) }
              column('Dates') { |booking| "#{booking.booking_start_date}-#{booking.booking_end_date}" }
              column('Monthly Rate') { |booking| number_to_currency(booking.actual_monthly_rate, precision: 0) }
            end
          end
        end
      end
    end
    div class: 'blank_slate_container', id: 'dashboard_lower' do
      columns do
        column do
          panel 'Apartments that need to be Rented' do
            table_for Apartment.needs_shopping, cellspacing: '10px' do
              column :building
              column('Apartment') { |apartment| link_to(apartment.name, admin_apartment_path(apartment)) }
              column('Bed/Bath/Rooms') { |apartment| "#{apartment.bedroom_count}/#{apartment.bathroom_count}/#{apartment.room_count}" }
              column('Amenities') { |apartment| apartment.amenities.pluck(:name).join(', ') }
              column :date_available
              column :monthly_rate do |rate|
                number_to_currency rate.monthly_rate, precision: 0
              end
            end
          end
        end
      end
    end
  end
end
