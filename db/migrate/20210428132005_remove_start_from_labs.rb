class RemoveStartFromLabs < ActiveRecord::Migration[6.0]
  def change
    remove_column :labs, :start, :text
  end
end
