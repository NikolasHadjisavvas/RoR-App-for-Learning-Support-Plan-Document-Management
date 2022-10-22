class RemoveModTitleFromUniModules < ActiveRecord::Migration[6.0]
  def change
    remove_column :uni_modules, :modTitle, :text
  end
end
