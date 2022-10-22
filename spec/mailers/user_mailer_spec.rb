require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  

    describe '#changes_to_student_email' do

        it 'sends the email' do

            users = ["test1mail@gmail.com","test2mail@gmail.com"]
            email = UserMailer.changes_to_student_email(users)

            expect(email.to).to eq ['no-reply@sheffield.ac.uk']
            expect(email.bcc).to eq users
            expect(email.from).to eq ['no-reply@sheffield.ac.uk']
            expect(email.subject).to eq 'Changes made to one or more of your students.Log into your account to see the changes.'

        end
    
    end


    describe '#send_reminder_email' do

        it 'sends the reminder email' do

            recipients = ["test1mail@gmail.com","test2mail@gmail.com"]
            content = 'Test content.'
            sender = FactoryBot.create :user , email: 'testemail@sheffield.ac.uk'

            email = UserMailer.send_reminder_email(sender,recipients,content)

            expect(email.to).to eq ['no-reply@sheffield.ac.uk']
            expect(email.bcc).to eq recipients
            expect(email.from).to eq [sender.email]
            expect(email.subject).to eq 'You have a reminder.'

        end


        it 'raises nomethoderror for nil sender.' do
            
            recipients = ["test1mail@gmail.com","test2mail@gmail.com"]
            content = 'Test content.'
            sender = nil

            email = UserMailer.send_reminder_email(sender,recipients,content)

            expect { email.from }.to raise_error(NoMethodError)


        end

    end

end

