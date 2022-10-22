require 'rails_helper'
require 'csv'

RSpec.describe Imports::ImporterPdf do
  describe '.import' do

    it 'adds info as expected' do
      student = FactoryBot.create :student, regNo: 210000001,programmeCode: 'COMU201',deptCode: 'COM',periodOfStudy: 'A'
      lsp = FactoryBot.create :lsp, regNo: 210000001
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/lsp_correct.pdf'), 'text/pdf')
      subject = Imports::ImporterPdf.new(file)
      expect(subject.import).to eq "LSP uploaded successfully."
      lspCreated = Lsp.find_by(regNo: 210000001)
      expect(lspCreated.disabilityInfo).to eq " Homer has a rare (and as-yet unnamed) condition. He is likely to encounter barriers  to learning in all aspects of his University experience.  "
    end

    it 'detects changes' do
      student = FactoryBot.create :student, regNo: 210000001,programmeCode: 'COMU201',deptCode: 'COM',periodOfStudy: 'A'
      lsp = FactoryBot.create :lsp, regNo: 210000001, disabilityInfo: "Marge has a rare (and as-yet unnamed) condition. He is likely to encounter barriers  to learning in all aspects of his University experience.  "
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/lsp_correct.pdf'), 'text/pdf')
      subject = Imports::ImporterPdf.new(file)
      expect(subject.import).to eq "LSP uploaded successfully."
      lspCreated = Lsp.find_by(regNo: 210000001)
      expect(lspCreated.disabilityInfo).to eq "<span class=mark> Homer has a rare (and as-yet unnamed) condition.</span> He is likely to encounter barriers  to learning in all aspects of his University experience.  "
    end

    it 'detects different file type' do

      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/module_test.csv'), 'text/csv')

      subject = Imports::ImporterPdf.new(file)
      expect(subject.import).to eq "File is in the wrong format. File of type '.pdf' is needed."
    end

    it 'detects that there is no registration number' do

      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/lsp_no_regno.pdf'), 'text/pdf')

      subject = Imports::ImporterPdf.new(file)
      expect(subject.import).to eq "No registration number detected."
    end

    it 'detects that student doesnt exist' do

      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/lsp_correct.pdf'), 'text/pdf')

      subject = Imports::ImporterPdf.new(file)
      expect(subject.import).to eq "There is no student with registration number 210000001."

    end
  end
end
