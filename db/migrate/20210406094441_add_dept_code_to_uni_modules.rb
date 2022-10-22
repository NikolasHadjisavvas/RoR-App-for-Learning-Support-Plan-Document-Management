class AddDeptCodeToUniModules < ActiveRecord::Migration[6.0]
  def change
    add_column :uni_modules, :deptCode, :text
  end
end
