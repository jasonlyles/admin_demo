ActiveAdmin.register Booking do
  config.per_page = [10, 25, 50]
  menu priority: 5
  permit_params :apartment_id, :booking_start_date, :booking_end_date, :notes, :status, :actual_monthly_rate, guest_ids: []

  scope :all, default: true
  BookingStatus::TYPES.each do |type|
    scope type.downcase.to_sym
  end

  filter :building
  filter :apartment
  filter :actual_monthly_rate, label: 'Monthly Rate'
  filter :guests
  filter :status, as: :select, collection: -> { BookingStatus::TYPES }
  filter :booking_start_date
  filter :booking_end_date

  actions :all, except: %i[destroy]

  sidebar 'Guests', only: [:show] do
    table_for booking.guests do
      column '', :full_name
    end
  end

  controller do
    def new
      @booking = Booking.new(apartment_id: params['apartment_id']) if params['apartment_id'].present?
      super
    end

    def index
      super do |format|
        format.pdf { render(pdf: 'bookings', layout: 'pdf', disposition: 'attachment') }
      end
    end
  end

  index download_links: %i[csv json pdf], row_class: ->(elem) { elem.booking_status_tense } do
    render 'admin/bookings/key'
    selectable_column
    column :building
    column :apartment
    column 'Start Date', :booking_start_date
    column 'End Date', :booking_end_date
    column :status
    column(:guests) { |booking| booking.guests.collect(&:full_name).join(', ') }
    column 'Monthly Rate', :actual_monthly_rate do |rate|
      number_to_currency(rate.actual_monthly_rate, precision: 0)
    end
    actions
  end

  show do
    attributes_table do
      row 'Building' do |booking|
        link_to booking.building.name, admin_building_path(booking.building.id)
      end
      row 'Apartment' do |booking|
        link_to booking.apartment.name, admin_apartment_path(booking.apartment_id)
      end
      row :booking_start_date
      row :booking_end_date
      row :status
      row :actual_monthly_rate do |rate|
        number_to_currency(rate.actual_monthly_rate, precision: 0)
      end
      row :notes
    end
  end

  form do |f|
    nested_select_disabled = false
    if params['apartment_id'].present? || params.dig(:booking, :apartment_id).present?
      apartment_id = params['apartment_id'].present? ? params['apartment_id'] : params.dig(:booking, :apartment_id)
      nested_select_disabled = true
      apartment = Apartment.find(apartment_id)
      actual_monthly_rate = apartment.monthly_rate
      render 'admin/shared/apartment_bookings', bookings: apartment.bookings
      br
    end

    f.semantic_errors *f.object.errors.keys

    f.inputs do
      if nested_select_disabled == true
        f.input :apartment_id, value: apartment_id, as: :hidden
      end

      f.input :apartment_id, as: :nested_select,
                             level_1: { attribute: :building_id, collection: Building.all },
                             level_2: { attribute: :apartment_id, collection: Apartment.all }, width: '30%', input_html: { disabled: nested_select_disabled }
      # f.input :guest_ids, as: :selected_list, label: 'Guests', width: '30%', display_name: :full_name, fields: [:full_name]
      f.input :guest_ids, as: :tags, label: 'Guests', collection: Guest.all, display_name: :full_name, fields: [:full_name]
      f.input :booking_start_date, as: :datepicker,
                                   datepicker_options: {
                                     min_date: Date.today,
                                     max_date: Date.today + 2.years
                                   }
      f.input :booking_end_date, as: :datepicker,
                                 datepicker_options: {
                                   min_date: Date.today + 1.month,
                                   max_date: Date.today + 5.years
                                 }
      f.input :status, as: :select, collection: BookingStatus::TYPES
      if actual_monthly_rate
        f.input :actual_monthly_rate, input_html: { value: actual_monthly_rate }
      else
        f.input :actual_monthly_rate
      end
      f.input :notes
    end
    f.actions
  end
end
