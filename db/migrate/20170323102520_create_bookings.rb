class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :listing
      t.date :end_date
      t.integer :num_guests

      t.timestamps null: false
    end
  end
end
