class AddClosingTimeToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :monday_closing_hr, :string
    add_column :businesses, :tuesday_closing_hr, :string
    add_column :businesses, :wednesday_closing_hr, :string
    add_column :businesses, :thursday_closing_hr, :string
    add_column :businesses, :friday_closing_hr, :string
    add_column :businesses, :saturday_closing_hr, :string
    add_column :businesses, :sunday_closing_hr, :string
  end
end
