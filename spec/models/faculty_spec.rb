# == Schema Information
#
# Table name: faculties
#
#  id         :bigint           not null, primary key
#  title      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Faculty, type: :model do
  it 'is valid with valid attributes' do
    expect(create(:faculty)).to be_valid
  end

  it 'is not valid without a title' do
    expect(Faculty.new).to_not be_valid
  end
end
