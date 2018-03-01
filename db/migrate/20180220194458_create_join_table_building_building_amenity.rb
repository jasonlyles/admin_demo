class CreateJoinTableBuildingBuildingAmenity < ActiveRecord::Migration[5.1]
  def change
    create_join_table :buildings, :building_amenities do |t|
      t.index %i[building_id building_amenity_id], name: 'index_building_to_building_amenity'
      t.index %i[building_amenity_id building_id], name: 'index_building_amenity_to_building'
    end
  end
end
