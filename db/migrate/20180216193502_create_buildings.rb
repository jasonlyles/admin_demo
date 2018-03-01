class CreateBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.string :name
      t.text :description
      t.string :street_address
      t.string :city
      t.integer :state_id
      t.string :zip
      t.string :manager_name
      t.string :phone_number
      t.text :notes

      t.timestamps
    end
  end
end
