class AddLastnameToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :lastname, :text
  end
end
