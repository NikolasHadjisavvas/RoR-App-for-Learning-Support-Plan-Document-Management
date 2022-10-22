class CreateJoinTableUniModuleLab < ActiveRecord::Migration[6.0]
  def change
    create_join_table :uni_modules, :labs do |t|
      t.index [:uni_module_id, :lab_id], unique: true
      t.index [:lab_id, :uni_module_id], unique: true
    end
  end
end
