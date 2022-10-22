class CreateLsps < ActiveRecord::Migration[6.0]
  def change
    create_table :lsps, id: false, primary_key: :regNo do |t|
      t.integer :regNo
      t.text :access
      t.text :contact
      t.text :teaching
      t.text :exams
      t.text :practicals
      t.text :circumstances
      t.text :recommendations

      t.timestamps
    end
  end
end
