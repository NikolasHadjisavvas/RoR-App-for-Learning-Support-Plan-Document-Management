class CreateJoinTableUniModulesStudents < ActiveRecord::Migration[6.0]
  def change
    create_join_table :uni_modules, :students do |t|
      t.index [:uni_module_id, :student_id], unique: true
      t.index [:student_id, :uni_module_id], unique: true
    end
  end
end
