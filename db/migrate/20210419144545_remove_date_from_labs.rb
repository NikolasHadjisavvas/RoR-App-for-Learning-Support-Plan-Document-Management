class RemoveDateFromLabs < ActiveRecord::Migration[6.0]
  def change
    remove_column :labs, :date, :date
  end
end
