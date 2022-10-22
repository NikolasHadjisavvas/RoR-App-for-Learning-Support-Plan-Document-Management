class AddFinishDateToLabs < ActiveRecord::Migration[6.0]
  def change
    add_column :labs, :finishdate, :datetime
  end
end
