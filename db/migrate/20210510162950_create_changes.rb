class CreateChanges < ActiveRecord::Migration[6.0]
  def change
    create_table :changes do |t|
      t.text :recipient
      t.text :sent , :default => "false"

      t.timestamps
    end
  end
end
