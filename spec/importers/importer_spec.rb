require 'rails_helper'
require 'csv'

RSpec.describe Imports::Importer do
  describe '.import' do


    it 'adds info as expected' do
      #add modules and tutors so they already exist
      uni_module1 = FactoryBot.create :uni_module, modCode: 'EEE117',deptCode: 'EEE'
      uni_module2 = FactoryBot.create :uni_module, modCode: 'EEE307',deptCode: 'EEE'
      uni_module3 = FactoryBot.create :uni_module, modCode: 'EEE227',deptCode: 'EEE'
      uni_module4 = FactoryBot.create :uni_module, modCode: 'EEE305',deptCode: 'EEE'
      uni_module5 = FactoryBot.create :uni_module, modCode: 'EEE226',deptCode: 'EEE'
      tutor1 = FactoryBot.create :user, email: 'IFarrer@sheffield.ac.uk'
      tutor2 = FactoryBot.create :user, email: 'TOFarrell@sheffield.ac.uk'
      supervisor = FactoryBot.create :user, email: 'k.bogdanov@sheffield.ac.uk'
      #upload file
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/student_test_works.csv'), 'text/csv')
      subject = Imports::Importer.new(file)
      expect(subject.import).to eq "File uploaded successfully."
      #check if modules have been added
      studentDone1 = Student.find_by(regNo: 210000001)
      studentDone2 = Student.find_by(regNo: 210000002)
      expect(studentDone1.uni_module_ids).to eq [uni_module1.id,uni_module2.id,uni_module3.id]
      expect(studentDone2.uni_module_ids).to eq [uni_module4.id,uni_module5.id]

    end

    it 'updates student info' do
      #add modules and tutors so they already exist
      uni_module1 = FactoryBot.create :uni_module, modCode: 'EEE117',deptCode: 'EEE'
      uni_module2 = FactoryBot.create :uni_module, modCode: 'EEE307',deptCode: 'EEE'
      uni_module3 = FactoryBot.create :uni_module, modCode: 'EEE227',deptCode: 'EEE'
      uni_module4 = FactoryBot.create :uni_module, modCode: 'EEE305',deptCode: 'EEE'
      uni_module5 = FactoryBot.create :uni_module, modCode: 'EEE226',deptCode: 'EEE'
      student1 = FactoryBot.create :student, regNo: 210000001, firstname: "Name"
      tutor1 = FactoryBot.create :user, email: 'IFarrer@sheffield.ac.uk'
      tutor2 = FactoryBot.create :user, email: 'TOFarrell@sheffield.ac.uk'
      supervisor = FactoryBot.create :user, email: 'k.bogdanov@sheffield.ac.uk'
      #upload file
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/student_test_works.csv'), 'text/csv')
      subject = Imports::Importer.new(file)
      expect(subject.import).to eq "File uploaded successfully."
      #check if modules have been added
      studentDone1 = Student.find_by(regNo: 210000001)
      expect(studentDone1.firstname).to eq "Homer"

    end

    it 'detects wrong regNo' do
      #add modules and tutors so they already exist
      uni_module1 = FactoryBot.create :uni_module, modCode: 'EEE117',deptCode: 'EEE'
      tutor1 = FactoryBot.create :user, email: 'IFarrer@sheffield.ac.uk'
      #upload file
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/student_regno_error.csv'), 'text/csv')
      subject = Imports::Importer.new(file)
      expect(subject.import).to eq "Registration number 1234567 is not 9 characters. Please try again."

    end

    it 'detects that the module youre adding doesnt exist' do
      #upload file
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/student_test_works.csv'), 'text/csv')
      subject = Imports::Importer.new(file)
      expect(subject.import).to eq "Module EEE117 does not exist. Please try again."

    end

    it 'detects that the academic youre adding doesnt exist' do
      #add modules and tutors so they already exist
      uni_module1 = FactoryBot.create :uni_module, modCode: 'EEE117',deptCode: 'EEE'
      uni_module2 = FactoryBot.create :uni_module, modCode: 'EEE307',deptCode: 'EEE'
      uni_module3 = FactoryBot.create :uni_module, modCode: 'EEE227',deptCode: 'EEE'
      uni_module4 = FactoryBot.create :uni_module, modCode: 'EEE305',deptCode: 'EEE'
      uni_module5 = FactoryBot.create :uni_module, modCode: 'EEE226',deptCode: 'EEE'
      #upload file
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/student_test_works.csv'), 'text/csv')
      subject = Imports::Importer.new(file)
      expect(subject.import).to eq "There is no academic with email: k.bogdanov@sheffield.ac.uk. Please try again."

    end
    
    it 'detects different file type' do

      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/lsp_correct.pdf'), 'text/pdf')

      subject = Imports::Importer.new(file)
      expect(subject.import).to eq "File is in the wrong format. File of type '.csv' is needed."

    end
    
    it 'detexts CSV columns are wrong' do

      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/module_test.csv'), 'text/csv')

      subject = Imports::Importer.new(file)
      expect(subject.import).to eq "CSV format is not valid. Wrong headers are: Registration_Number, Surname, Forename, Title, E_Mail_Address, Supervisors_Surname, Supervisors_Initials, SupervisorsEmail, Tutor_Surname, Tutor_Initials, TutorEmail, Programme_Code, Calendar_Occurrence_Code, Programme_Period_Code, Expected_Completion_Date, Unit_Code, Calendar_Type_Code, Owned_By_Code."

    end
  end
end
