class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students, id: false, primary_key: :regNo do |t|
      t.integer :regNo
      t.text :programmeCode
      t.text :deptCode
      t.text :personalTutor
      t.text :periodOfStudy

      t.timestamps
    end
  end
end
