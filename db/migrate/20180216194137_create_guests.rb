class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :gender
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :email
      t.string :phone_number
      t.date :date_of_birth
      t.text :notes

      t.timestamps
    end
  end
end
