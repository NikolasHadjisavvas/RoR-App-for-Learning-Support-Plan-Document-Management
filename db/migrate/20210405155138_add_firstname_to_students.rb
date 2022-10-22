class AddFirstnameToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :firstname, :text
  end
end
