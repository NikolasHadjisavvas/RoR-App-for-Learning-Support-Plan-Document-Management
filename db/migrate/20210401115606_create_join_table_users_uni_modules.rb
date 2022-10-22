class CreateJoinTableUsersUniModules < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :uni_modules do |t|
      t.index [:user_id, :uni_module_id], unique: true
      t.index [:uni_module_id, :user_id], unique: true
    end
  end
end
