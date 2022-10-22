class AddAdvisorNameToLsps < ActiveRecord::Migration[6.0]
  def change
    add_column :lsps, :advisor_name, :text
  end
end
