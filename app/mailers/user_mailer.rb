#Mailer file, here the mailer methods which are used for sending manual and automated reminders are included.

class UserMailer < ApplicationMailer
    default from: 'Application Name <no-reply@sheffield.ac.uk>'

    #mailer to send automated emails to academics each time there's a change to their students records.
    #params: users(recipients)
    def changes_to_student_email(users)
        mail(to: 'no-reply@sheffield.ac.uk', bcc: users, subject: 'Changes made to one or more of your students.Log into your account to see the changes.')
    end

    #manual reminder email
    # sender(the sender of the email), recipients, content(the ontent of the reminder)
    def send_reminder_email(sender,recipients, content)
        @content = content
        @sender = sender
        @recipients = recipients
        sender_email = sender.email
        from_t = 'Application name <' + sender_email + '>'
        mail(from: from_t, to: 'no-reply@sheffield.ac.uk', bcc: recipients, subject: 'You have a reminder.')
    end

end
