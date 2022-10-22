class AddTutorEmailToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :tut_email, :text
  end
end
