# == Schema Information
#
# Table name: changes
#
#  id         :bigint           not null, primary key
#  recipient  :text
#  sent       :text             default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Change < ApplicationRecord

    validates :recipient, presence: true

    """
    Method for gathering all unsent/untracked(sent = false) changes 
    with recipients that receive reminders every day ,sending an email
    reminder to these recipients/users and updating the sent field of the 
    change/reminder to true/tracked.
    """
    def self.send_change_reminders_to_user_1day

        changes_to_notify = Change.where(sent: "false")
        changes_to_notify.each do |change|
            user_email = change.recipient
            user = User.find_by(mail: user_email)
            if user.notification_freq == 1 then
                UserMailer.changes_to_student_email(user_email).deliver
                change.update(sent: "true")
            end
        end


    end

    """
    Method for gathering all unsent/untracked(sent = false) changes 
    with recipients that receive reminders every 5 days ,sending an email
    reminder to these recipients/users and updating the sent field of the 
    change/reminder to true/tracked.
    """
    def self.send_change_reminders_to_user_5days

        changes_to_notify = Change.where(sent: "false")
        changes_to_notify.each do |change|
            user_email = change.recipient
            user = User.find_by(mail: user_email)
            if user.notification_freq == 5 then
                UserMailer.changes_to_student_email(user_email).deliver
                change.update(sent: "true")
            end
        end


    end

    """
    Method for gathering all unsent/untracked(sent = false) changes 
    with recipients that receive reminders every 3 days ,sending an email
    reminder to these recipients/users and updating the sent field of the 
    change/reminder to true/tracked.
    """
    def self.send_change_reminders_to_user_3days

        changes_to_notify = Change.where(sent: "false")
        changes_to_notify.each do |change|
            user_email = change.recipient
            user = User.find_by(mail: user_email)
            if user.notification_freq == 3 then
                UserMailer.changes_to_student_email(user_email).deliver
                change.update(sent: "true")
            end
        end


    end

    """
    Method for gathering all unsent/untracked(sent = false) changes 
    with recipients that receive reminders every time there is a 
    change regarding their students ,sending an email
    reminder to these recipients/users and updating the sent field of the 
    change/reminder to true/tracked.
    """
    def self.send_change_reminders_to_user_1min

        changes_to_notify = Change.where(sent: "false")
        changes_to_notify.each do |change|
            user_email = change.recipient
            user = User.find_by(mail: user_email)
            if user.notification_freq == 3 then
                UserMailer.changes_to_student_email(user_email).deliver
                change.update(sent: "true")
            end
        end


    end

    


end
