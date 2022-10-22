require 'rails_helper'
require 'csv'

RSpec.describe Imports::ImporterModules do
  describe '#import' do


    it 'adds info as expected' do
      #confirm they don't exist from before
      expect(User.find_by(email: "k.bogdanov@sheffield.ac.uk")).to eq nil
      expect(UniModule.find_by(modCode: "COM2109")).to eq nil
      #upload file
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/module_test.csv'), 'text/csv')
      subject = Imports::ImporterModules.new(file)
      expect(subject.import).to eq "File uploaded successfully."

      #check details are correct
      newModule = UniModule.find_by(modCode: "COM2109")
      newAcademic = User.find_by(email: "k.bogdanov@sheffield.ac.uk")
      expect(newAcademic.role).to eq "Academic"
      expect(newAcademic.sn).to eq "Bogdanov"
      expect(newAcademic.givenname).to eq "Kirill"
      expect(newModule.deptCode).to eq "COM"

    end

    it 'updates info if academic already exists' do
      #create the academic from before
      academic = FactoryBot.create :user, email: 'k.bogdanov@sheffield.ac.uk', givenname: "Name"
      #upload file
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/module_test.csv'), 'text/csv')
      subject = Imports::ImporterModules.new(file)
      expect(subject.import).to eq "File uploaded successfully."
      #check the details changed
      newAcademic = User.find_by(email: "k.bogdanov@sheffield.ac.uk")
      expect(newAcademic.givenname).to eq "Kirill"

    end

    it 'detects different file type' do
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/lsp_correct.pdf'), 'text/pdf')
      subject = Imports::ImporterModules.new(file)
      expect(subject.import).to eq "File is in the wrong format. File of type '.csv' is needed."
    end

    it 'detexts CSV columns are wrong' do
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/student_test_works.csv'), 'text/csv')
      subject = Imports::ImporterModules.new(file)
      expect(subject.import).to eq "CSV format is not valid. Wrong headers are: Module Code, Semester type, Academic 1, Email, Academic 1 Dept, Academic 2, Email, Academic 2 Dept, Academic 3, Email, Academic 3 Dept."
    end
    
  end

  describe '#academicExists' do


    it 'detects that academic doesnt exist' do
      emailString = "k.bogdanov@sheffield.ac.uk"
      expect(Imports::ImporterModules.academicExists(emailString)).to eq false
    end

    it 'detects that academic exists' do
      
      emailString = "k.bogdanov@sheffield.ac.uk"
      academic = FactoryBot.create :user, email: 'k.bogdanov@sheffield.ac.uk'
      expect(Imports::ImporterModules.academicExists(emailString)).to eq true
    end
    
  end
end
