"""
Defining the rake tasks for sending the automated reminders to users.
"""

require 'rake'

"""Task to be executed every day, sending reminders to specific users"""
namespace :send_changes_reminder_1day do
  desc 'send an email reminder to the academic if a student detail has changed'
  task send_mail: :environment do
    Change.send_change_reminders_to_user_1day
  end
  
end

"""Task to be executed every 3 days, sending reminders to specific users"""
namespace :send_changes_reminder_3days do
  desc 'send an email reminder to the academic if a student detail has changed'
  task send_mail: :environment do
    Change.send_change_reminders_to_user_3days
  end
end

"""Task to be executed every 5 days, sending reminders to specific users"""
namespace :send_changes_reminder_5days do
  desc 'send an email reminder to the academic if a student detail has changed'
  task send_mail: :environment do
    Change.send_change_reminders_to_user_5days
  end
end

"""Task to be executed every 1 minute, sending reminders to specific users"""
namespace :send_changes_reminder_1min do
  desc 'send an email reminder to the academic if a student detail has changed'
  task send_mail: :environment do
    Change.send_change_reminders_to_user_1min
  end
  
end
