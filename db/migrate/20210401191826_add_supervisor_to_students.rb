class AddSupervisorToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :supervisor, :text
  end
end
