class RemoveUniModuleIdFromLabs < ActiveRecord::Migration[6.0]
  def change
    remove_column :labs, :uni_module_id, :bigint
  end
end
