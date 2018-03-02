ActiveAdmin.register BuildingAmenity do
  menu parent: 'Admin'

  permit_params :name

  config.filters = false

  sidebar 'Existing Amenities', only: %i[new edit] do
    table_for BuildingAmenity.all do
      column '', :name
    end
  end

  index do
    selectable_column
    column 'Name' do |amenity|
      link_to amenity.name, admin_building_amenity_path(amenity)
    end
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
