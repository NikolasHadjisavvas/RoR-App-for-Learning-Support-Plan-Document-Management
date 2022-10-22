class AddEmailToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :email, :text
  end
end
