class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :price
      t.string :street, :city, :state, :zipcode, :phone, :neighborhood
      t.string :monday_hr, :tuesday_hr, :wednesday_hr, :thursday_hr, :friday_hr, :saturday_hr, :sunday_hr
      t.timestamps
    end
  end
end
