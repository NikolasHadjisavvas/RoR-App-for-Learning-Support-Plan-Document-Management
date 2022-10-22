class CreateUniModules < ActiveRecord::Migration[6.0]
  def change
    create_table :uni_modules do |t|
      t.text :modCode
      t.text :modTitle

      t.timestamps
    end
  end
end
