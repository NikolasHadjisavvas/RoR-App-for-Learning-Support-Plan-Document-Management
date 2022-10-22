require 'rake'

"""Task to be executed every day, sending reminders to specific users"""
namespace :delete_graduated_students do
  desc 'delete student records that graduated more than a year ago'
  task delete_grad_students: :environment do
    Student.delete_graduated_students
  end
  
end