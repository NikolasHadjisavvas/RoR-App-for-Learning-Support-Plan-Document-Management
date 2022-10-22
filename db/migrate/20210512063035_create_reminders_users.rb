class CreateRemindersUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :reminders_users do |t|
      t.bigint :reminder_id
      t.bigint :user_id
    end
  end
end
