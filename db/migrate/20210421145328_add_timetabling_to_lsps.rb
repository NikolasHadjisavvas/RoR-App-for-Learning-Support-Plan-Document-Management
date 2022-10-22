class AddTimetablingToLsps < ActiveRecord::Migration[6.0]
  def change
    add_column :lsps, :timetabling, :text
  end
end
