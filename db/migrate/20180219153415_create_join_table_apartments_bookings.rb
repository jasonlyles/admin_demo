class CreateJoinTableApartmentsBookings < ActiveRecord::Migration[5.1]
  def change
    create_join_table :apartments, :bookings do |t|
      t.index %i[apartment_id booking_id]
      t.index %i[booking_id apartment_id]
      t.date :status_date
      t.boolean :available
    end
  end
end
