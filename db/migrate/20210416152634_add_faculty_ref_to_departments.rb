class AddFacultyRefToDepartments < ActiveRecord::Migration[6.0]
  def change
    add_reference :departments, :faculty, null: false, foreign_key: true
  end
end
