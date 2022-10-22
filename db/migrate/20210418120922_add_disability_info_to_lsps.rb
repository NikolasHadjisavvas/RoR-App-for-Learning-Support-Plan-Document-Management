class AddDisabilityInfoToLsps < ActiveRecord::Migration[6.0]
  def change
    add_column :lsps, :disabilityInfo, :text
  end
end
