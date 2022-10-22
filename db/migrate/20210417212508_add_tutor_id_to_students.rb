class AddTutorIdToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :tutor_id, :integer
  end
end
