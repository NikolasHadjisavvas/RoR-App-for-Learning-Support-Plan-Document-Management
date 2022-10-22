class AddSupervisorEmailToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :sup_email, :text
  end
end
