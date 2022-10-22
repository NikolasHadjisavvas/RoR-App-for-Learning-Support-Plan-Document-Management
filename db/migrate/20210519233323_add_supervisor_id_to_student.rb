class AddSupervisorIdToStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :sup_id, :integer
  end
end
