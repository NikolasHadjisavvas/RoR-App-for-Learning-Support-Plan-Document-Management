class CreateLabs < ActiveRecord::Migration[6.0]
  def change
    create_table :labs do |t|
      t.integer :eventId
      t.text :start
      t.text :finish
      t.text :day
      t.text :room
      t.text :roomname
      t.datetime :date

      t.timestamps
    end
  end
end
