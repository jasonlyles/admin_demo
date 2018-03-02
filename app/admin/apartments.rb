ActiveAdmin.register Apartment do
  config.per_page = [10, 25, 50]
  menu priority: 3
  config.create_another = true

  includes :amenities, :bookings, :guests
  permit_params :building_id, :apartment_type, :apt_number, :bathroom_count, :bedroom_count, :room_count, :notes, :monthly_rate, amenity_ids: []

  filter :apartment_type, as: :select, collection: -> { ApartmentType::TYPES }
  filter :building_id, as: :select, collection: -> { Building.all }
  filter :apt_number
  filter :monthly_rate
  filter :bedroom_count, as: :check_boxes, collection: -> { Apartment::BEDROOM_COUNT }
  filter :bathroom_count, as: :check_boxes, collection: -> { Apartment::BATHROOM_COUNT }

  actions :all, except: [:destroy]

  scope :all, default: true
  scope :with_no_tenant_history

  batch_action :update_price, form: {
    rate: :text
  } do |ids, inputs|
    batch_action_collection.find(ids).each do |apartment|
      apartment.monthly_rate = inputs['rate']
      apartment.save
    end
    redirect_to collection_path, notice: 'Apartment Pricing Updated'
  end

  controller do
    def index
      super do |format|
        format.pdf { render(pdf: 'apartments', layout: 'pdf', disposition: 'attachment') }
      end
    end
  end

  index download_links: %i[csv json pdf] do
    selectable_column
    column 'Building' do |apt|
      link_to apt.building.name, admin_building_path(apt.building)
    end
    column 'Apartment Number' do |apt|
      link_to apt.apt_number, admin_apartment_path(apt)
    end
    column :apartment_type
    column 'Bed/Bath', sortable: :bedroom_count do |apt|
      "#{apt.bedroom_count}/#{apt.bathroom_count}"
    end
    column :monthly_rate, sortable: :monthly_rate do |apt|
      number_to_currency(apt.monthly_rate, precision: 0)
    end
    column :date_available
    actions
  end

  show do
    attributes_table do
      row 'Building' do |bldg|
        link_to bldg.building.name, admin_building_path(bldg.building_id)
      end
      row :apartment_type
      row :apt_number
      row :bedroom_count
      row :bathroom_count
      row :room_count
      row :monthly_rate do |rate|
        number_to_currency(rate.monthly_rate, precision: 0)
      end
      row :notes
    end
    render 'admin/shared/apartment_bookings', bookings: apartment.bookings
  end

  action_item :book_now, only: :show do
    link_to 'Book Now', controller: 'admin/bookings', action: :new, apartment_id: apartment.id
  end

  sidebar 'Amenities', only: [:show] do
    table_for apartment.amenities do
      column '', :name
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    tabs do
      tab 'Basics' do
        f.inputs 'Basic Details' do
          f.input :building_id, as: :select, collection: Building.all, include_blank: 'Select Building'
          f.input :apartment_type, as: :select, collection: ApartmentType::TYPES, include_blank: 'Select Apt Type'
          f.input :apt_number
          f.input :bedroom_count, as: :select, collection: Apartment::BEDROOM_COUNT, include_blank: 'Select Bedrooms'
          f.input :bathroom_count, as: :select, collection: Apartment::BATHROOM_COUNT, include_blank: 'Select Bathrooms'
          f.input :room_count, as: :select, collection: Apartment::ROOM_COUNT, include_blank: 'Select Rooms'
          f.input :monthly_rate
          f.input :notes
        end
      end
      tab 'Amenities' do
        f.inputs 'Amenities' do
          f.input :amenities, as: :check_boxes, collection: Amenity.all.pluck(:name, :id)
        end
      end
    end
    f.actions
  end
end
