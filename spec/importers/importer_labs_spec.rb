require 'rails_helper'
require 'csv'

RSpec.describe Imports::ImporterLabs do
  describe '.import' do


    it 'adds info as expected' do
     #confirm they don't exist from before
     expect(Lab.find_by(eventId: 979101)).to eq nil
     expect(Lab.find_by(eventId: 911590)).to eq nil

     student1 = FactoryBot.create :student, regNo: 210000001, firstname: "Name"
     student2 = FactoryBot.create :student, regNo: 210000002, firstname: "Name"
     student3 = FactoryBot.create :student, regNo: 210000003, firstname: "Name"
     uni_module1 = FactoryBot.create :uni_module, modCode: 'MEC1000',deptCode: 'MEC'
     uni_module2 = FactoryBot.create :uni_module, modCode: 'CPE260',deptCode: 'CPE'
     #upload file
     file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/labs_works.csv'), 'text/csv')
     subject = Imports::ImporterLabs.new(file)
     expect(subject.import).to eq "File uploaded successfully."
    end

    it 'detects different file type' do
     #upload file
     file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/lsp_correct.pdf'), 'text/pdf')
     subject = Imports::ImporterLabs.new(file)
     expect(subject.import).to eq "File is in the wrong format. File of type '.csv' is needed."
    end

  end
end
