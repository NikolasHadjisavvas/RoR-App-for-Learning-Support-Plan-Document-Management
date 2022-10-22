class AddDateOfCompletionToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :completion_date, :date
  end
end
