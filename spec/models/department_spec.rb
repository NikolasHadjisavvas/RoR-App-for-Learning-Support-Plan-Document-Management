# == Schema Information
#
# Table name: departments
#
#  deptCode   :text             primary key
#  deptTitle  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  faculty_id :bigint           not null
#
# Indexes
#
#  index_departments_on_faculty_id  (faculty_id)
#
# Foreign Keys
#
#  fk_rails_...  (faculty_id => faculties.id)
#
require 'rails_helper'

RSpec.describe Department, type: :model do

  it 'is valid with valid attributes' do
    create(:faculty)
    expect(Department.new(deptCode: 'COM', deptTitle: 'Department of Computer Science', faculty_id: subject.id)).to be_valid
  end

  it 'is not valid without a deptCode' do
    create(:faculty)
    expect(Department.new(deptTitle: 'Department of Computer Science', faculty_id: subject.id)).to_not be_valid
  end

  it 'is not valid without a deptTitle' do
    create(:faculty)
    expect(Department.new(deptCode: 'COM', faculty_id: subject.id)).to_not be_valid
  end




  describe '#codeAndTitle' do
    it 'returns the concatenation of the department code and title with formatting' do
      create(:faculty)
      dept = Department.new(deptCode: 'COM', deptTitle: 'Computer Science', faculty_id: subject.id)
      expect(dept.codeAndTitle).to eq 'COM - Computer Science'
    end
  end
end
