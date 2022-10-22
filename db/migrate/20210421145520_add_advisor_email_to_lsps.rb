class AddAdvisorEmailToLsps < ActiveRecord::Migration[6.0]
  def change
    add_column :lsps, :advisor_email, :text
  end
end
