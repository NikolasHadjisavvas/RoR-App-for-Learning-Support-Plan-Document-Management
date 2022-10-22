class CreateReminders < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders do |t|
      t.text :body
      t.boolean :toAll

      t.timestamps
    end
  end
end
