ActiveAdmin.register Building do
  config.per_page = [10, 25, 50]
  menu priority: 2
  includes :building_amenities, :apartments
  permit_params :name, :description, :street_address, :city, :state_id, :zip, :manager_name, :phone_number, :notes, building_amenity_ids: []

  remove_filter :description, :notes, :state_id, :created_at, :updated_at, :apartments

  actions :all, except: %i[destroy]

  show do
    attributes_table do
      row :name
      row :description
      row :address do |address|
        "#{address.street_address} #{address.city}, #{address.state.abbreviation} #{address.zip}"
      end
      row :manager_name
      row :phone_number do |guest|
        render 'admin/shared/phone_number', phone: guest.phone_number
      end
      row :notes
    end
    render 'admin/shared/building_bookings', bookings: building.bookings
  end

  sidebar 'Amenities', only: [:show] do
    table_for building.building_amenities do
      column '', :name
    end
  end

  index do
    selectable_column
    column 'Name' do |building|
      link_to building.name, admin_building_path(building)
    end
    column :city
    column :state
    column :zip
    column :manager_name
    column :phone_number
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    tabs do
      tab 'Basics' do
        f.inputs 'Basic Details' do
          f.input :name
          f.input :description
          f.input :notes
        end
      end
      tab 'Address' do
        f.inputs 'Street Address' do
          f.input :street_address
          f.input :city
          f.input :state, as: :select, collection: State.all, include_blank: 'Select State'
          f.input :zip
        end
      end
      tab 'Contact' do
        f.inputs 'Contact Info' do
          f.input :manager_name
          f.input :phone_number
        end
      end
      tab 'Amenities' do
        f.inputs 'Amenities' do
          f.input :building_amenities, as: :check_boxes, collection: BuildingAmenity.all.pluck(:name, :id)
        end
      end
    end
    f.actions
  end
end
