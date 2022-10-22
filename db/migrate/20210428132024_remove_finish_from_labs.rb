class RemoveFinishFromLabs < ActiveRecord::Migration[6.0]
  def change
    remove_column :labs, :finish, :text
  end
end
