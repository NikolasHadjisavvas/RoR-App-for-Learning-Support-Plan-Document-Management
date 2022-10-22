# == Schema Information
#
# Table name: uni_modules
#
#  id         :bigint           not null, primary key
#  deptCode   :text
#  modCode    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe UniModule, type: :model do
  it 'is valid with valid attributes' do
    expect(UniModule.new(modCode: 'COM1001', deptCode: 'COM')).to be_valid
  end

  it 'is not valid without a modCode' do
    expect(UniModule.new(deptCode: 'COM')).to_not be_valid
  end

  it 'is not valid without a deptCode' do
    expect(UniModule.new(modCode: 'COM1001')).to_not be_valid
  end

  it 'is not valid if the modCode is not unique' do
    UniModule.create(modCode: 'COM1001', deptCode: 'COM')
    expect(UniModule.new(modCode: 'COM1001', deptCode: 'COM')).to_not be_valid
  end
end
