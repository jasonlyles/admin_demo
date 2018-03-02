ActiveAdmin.register Amenity do
  menu parent: 'Admin'

  permit_params :name

  config.filters = false

  index do
    selectable_column
    column 'Name' do |amenity|
      link_to amenity.name, admin_amenity_path(amenity)
    end
    actions
  end

  sidebar 'Existing Amenities', only: %i[new edit] do
    table_for Amenity.all do
      column '', :name
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
