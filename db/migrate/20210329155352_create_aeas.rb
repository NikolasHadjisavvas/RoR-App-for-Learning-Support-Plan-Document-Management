class CreateAeas < ActiveRecord::Migration[6.0]
  def change
    create_table :aeas, id: false, primary_key: :regNo do |t|
      t.text :regNo
      t.text :requirements
      t.text :other
      t.text :information
      t.text :illness
      t.text :consent
      t.text :duration
      t.text :additional

      t.timestamps
    end
  end
end
