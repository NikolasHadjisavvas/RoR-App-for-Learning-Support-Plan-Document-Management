class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments, id: false, primary_key: :deptCode do |t|
      t.text :deptCode
      t.text :deptTitle

      t.timestamps
    end
  end
end
