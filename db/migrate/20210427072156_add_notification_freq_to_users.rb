class AddNotificationFreqToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :notification_freq, :integer, :default => 3
  end
end
