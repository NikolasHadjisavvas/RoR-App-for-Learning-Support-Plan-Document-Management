# == Schema Information
#
# Table name: lsps
#
#  access          :text
#  advisor_email   :text
#  advisor_name    :text
#  circumstances   :text
#  contact         :text
#  disabilityInfo  :text
#  disabilitytype  :text
#  exams           :text
#  practicals      :text
#  recommendations :text
#  regNo           :integer          primary key
#  teaching        :text
#  timetabling     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Lsp, type: :model do
  it 'is valid with valid attributes' do
    expect(Lsp.new(regNo: 200000001)).to be_valid
  end

  it 'is not valid without regNo' do
    expect(Lsp.new).to_not be_valid
  end

  it 'is not valid if the regNo is not unique' do
    lsp = Lsp.create(regNo: 200000001)
    expect(Lsp.new(regNo: 200000001)).to_not be_valid
  end
end
