class AddUserIdToLabs < ActiveRecord::Migration[6.0]
  def change
    add_column :labs, :user_id, :bigint
  end
end
