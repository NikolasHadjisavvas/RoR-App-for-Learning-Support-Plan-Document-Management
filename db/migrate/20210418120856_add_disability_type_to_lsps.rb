class AddDisabilityTypeToLsps < ActiveRecord::Migration[6.0]
  def change
    add_column :lsps, :disabilitytype, :text
  end
end
