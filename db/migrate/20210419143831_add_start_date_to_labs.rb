class AddStartDateToLabs < ActiveRecord::Migration[6.0]
  def change
    add_column :labs, :startdate, :datetime
  end
end
