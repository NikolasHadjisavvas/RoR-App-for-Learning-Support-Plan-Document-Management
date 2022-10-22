class CreateJoinTableStudentLab < ActiveRecord::Migration[6.0]
  def change
    create_join_table :students, :labs do |t|
      t.index [:student_id, :lab_id]
      t.index [:lab_id, :student_id]
    end
  end
end
