class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :apartment_id
      t.date :booking_start_date
      t.date :booking_end_date
      t.string :status
      t.float :actual_monthly_rate
      t.text :notes

      t.timestamps
    end
  end
end
