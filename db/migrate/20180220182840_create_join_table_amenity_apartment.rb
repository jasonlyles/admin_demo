class CreateJoinTableAmenityApartment < ActiveRecord::Migration[5.1]
  def change
    create_join_table :amenities, :apartments do |t|
      t.index %i[amenity_id apartment_id]
    end
  end
end
