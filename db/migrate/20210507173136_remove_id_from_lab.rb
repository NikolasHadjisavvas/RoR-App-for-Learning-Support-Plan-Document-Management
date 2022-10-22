class RemoveIdFromLab < ActiveRecord::Migration[6.0]
  def change
    remove_column :labs, :id, :integer
  end
end
