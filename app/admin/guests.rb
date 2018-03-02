ActiveAdmin.register Guest do
  config.per_page = [10, 25, 50]
  menu priority: 4
  config.create_another = true

  includes :bookings
  permit_params :gender, :first_name, :last_name, :date_of_birth, :notes, :email, :phone_number

  filter :gender, as: :select, collection: -> { Gender::TYPES }
  filter :first_name
  filter :last_name
  filter :date_of_birth

  # Just pretending to send emails here.
  batch_action :send_welcome_email_to do |ids|
    if ids.length <= 5
      users = []
      batch_action_collection.find(ids).each do |user|
        users << user.full_name
      end
      alert = "Sent welcome emails to #{users.to_sentence}"
    else
      alert = "Sent welcome emails to #{ids.length} guests"
    end
    redirect_to collection_path, alert: alert
  end

  controller do
    def index
      super do |format|
        format.pdf { render(pdf: 'guests', layout: 'pdf', disposition: 'attachment') }
      end
    end
  end

  index download_links: %i[csv json pdf] do
    selectable_column
    column 'Name' do |guest|
      link_to guest.full_name, admin_guest_path(guest)
    end
    column :first_name
    column :last_name
    column :email
    column :date_of_birth
    column :tenant_status
    actions
  end

  show do
    attributes_table do
      row :gender
      row :full_name
      row :email
      row :phone_number do |guest|
        render 'admin/shared/phone_number', phone: guest.phone_number
      end
      row :date_of_birth
      row :tenant_status
      row :notes
    end
    render 'admin/shared/guest_bookings', bookings: guest.bookings
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :gender, as: :select, collection: Gender::TYPES, include_blank: 'Select Gender'
      f.input :first_name
      f.input :last_name
      f.input :date_of_birth, as: :datepicker,
                              datepicker_options: {
                                min_date: '1900-01-01',
                                max_date: '-25Y'
                              }
      f.input :email
      f.input :phone_number
      f.input :notes
    end
    f.actions
  end
end
