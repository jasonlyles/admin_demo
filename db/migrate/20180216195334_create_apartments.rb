class CreateApartments < ActiveRecord::Migration[5.1]
  def change
    create_table :apartments do |t|
      t.integer :building_id
      t.string :apartment_type
      t.string :apt_number
      t.float :bathroom_count
      t.integer :bedroom_count
      t.integer :room_count
      t.float :monthly_rate
      t.text :notes

      t.timestamps
    end
  end
end
