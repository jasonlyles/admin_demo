class CreateBuildingAmenities < ActiveRecord::Migration[5.1]
  def change
    create_table :building_amenities do |t|
      t.string :name

      t.timestamps
    end
  end
end
