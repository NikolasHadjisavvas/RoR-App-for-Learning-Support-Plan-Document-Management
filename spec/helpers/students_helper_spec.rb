require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StudentsHelper. For example:
#
# describe StudentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end


RSpec.describe StudentsHelper, type: :helper do
  

  describe '#sortStudents' do
    it 'returns an array of triples ordered by last updated LSP' do
      student1 = create(:student)
      student2 = create(:student)
      student3 = create(:student)
      lsp1 = create(:lsp, regNo: student1.regNo)
      lsp2 = create(:lsp, regNo: student2.regNo)
      lsp3 = create(:lsp, regNo: student3.regNo)
      students = Student.all
      students_with_lsps = [[student3, lsp3, lsp3.updated_at], [student2, lsp2, lsp2.updated_at], [student1, lsp1, lsp1.updated_at]]
      expect(helper.sortStudents(students)).to eq(students_with_lsps)
    end
  end

  
  describe '#getTutorName' do
    it 'returns an empty string if the tutor_id field is nil and the surname of the tutor if it exists so that the column is not empty' do
      user = create(:user, sn:'Name', role: 'Academic')
      student1 = create(:student)
      student2 = create(:student, tutor_id: user.id)
      expect(helper.getTutorName(student1)).to eq("")
      expect(helper.getTutorName(student2)).to eq("Name")
    end
  end
end
