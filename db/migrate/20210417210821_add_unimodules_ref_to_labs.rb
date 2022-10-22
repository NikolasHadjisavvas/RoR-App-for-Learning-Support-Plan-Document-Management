class AddUnimodulesRefToLabs < ActiveRecord::Migration[6.0]
  def change
    add_reference :labs, :uni_module, null: false, foreign_key: true
  end
end
