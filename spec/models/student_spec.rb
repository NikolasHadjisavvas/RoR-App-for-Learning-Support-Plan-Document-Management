# == Schema Information
#
# Table name: students
#
#  completion_date :date
#  deptCode        :text
#  email           :text
#  firstname       :text
#  lastname        :text
#  periodOfStudy   :text
#  personalTutor   :text
#  programmeCode   :text
#  regNo           :integer          primary key
#  sup_email       :text
#  supervisor      :text
#  tut_email       :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sup_id          :integer
#  tutor_id        :integer
#
require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'is valid with valid attributes' do
    expect(create(:student)).to be_valid
  end

  it 'is not valid if the regNo is not unique' do
    student = create(:student)
    expect(Student.new(regNo: student.regNo, deptCode: 'COM', periodOfStudy: 'A', personalTutor: 'Name', programmeCode: 'COMU01')).to_not be_valid
  end

  it 'is not valid if the deptCode is not of length 3' do
    expect(Student.new(regNo: 200000001, deptCode: 'COMO', periodOfStudy: 'A', personalTutor: 'Name', programmeCode: 'COMU01')).to_not be_valid
  end

  it 'is not valid if the programmeCode is not of length 7 or less' do
    expect(Student.new(regNo: 200000001, deptCode: 'COM', periodOfStudy: 'A', personalTutor: 'Name', programmeCode: 'COMU0100')).to_not be_valid
  end

  it 'is not valid without a regNo' do
    expect(Student.new(deptCode: 'COMO', periodOfStudy: 'A', personalTutor: 'Name', programmeCode: 'COMU01')).to_not be_valid
  end

  it 'is not valid without a deptCode' do
    expect(Student.new(regNo: 200000001, periodOfStudy: 'A', personalTutor: 'Name', programmeCode: 'COMU01')).to_not be_valid
  end

  it 'is not valid without a periodOfStudy' do
    expect(Student.new(regNo: 200000001, deptCode: 'COMO', personalTutor: 'Name', programmeCode: 'COMU01')).to_not be_valid
  end

  it 'is not valid without a personalTutor' do
    expect(Student.new(regNo: 200000001, deptCode: 'COMO', periodOfStudy: 'A', programmeCode: 'COMU01')).to_not be_valid
  end

  it 'is not valid without a programmeCode' do
    expect(Student.new(regNo: 200000001, deptCode: 'COMO', periodOfStudy: 'A', personalTutor: 'Name')).to_not be_valid
  end
end
