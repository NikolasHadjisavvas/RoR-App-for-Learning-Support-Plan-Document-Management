class CreateFaculties < ActiveRecord::Migration[6.0]
  def change
    create_table :faculties do |t|
      t.text :title

      t.timestamps
    end
  end
end
