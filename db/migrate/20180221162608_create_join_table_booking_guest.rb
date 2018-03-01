class CreateJoinTableBookingGuest < ActiveRecord::Migration[5.1]
  def change
    create_join_table :bookings, :guests do |t|
      # t.index [:booking_id, :guest_id]
      # t.index [:guest_id, :booking_id]
    end
  end
end
