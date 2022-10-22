# == Schema Information
#
# Table name: changes
#
#  id         :bigint           not null, primary key
#  recipient  :text
#  sent       :text             default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Change, type: :model do


  describe '#new' do 
    it 'creates a change record' do

      change = Change.new(recipient: "test@gmail.com")
      expect(change.save!).to eq true

    end

    it 'refuses to create a new change record without a recipient' do

      change = Change.create(recipient: nil, sent:false)
      expect(change.valid?).to eq false

    end

  end

  describe '#update' do
    it 'updates a change record' do

      change = Change.create(recipient: "testRecipient@sheffield.ac.uk", sent: 'False')
      expect(change.update(sent: 'True')).to eq true
    end

  end

  describe '#destroy' do
    it 'destroys a change record' do

      change = Change.create(id: 1,recipient: "testRecipient@sheffield.ac.uk", sent: 'False')
      Change.destroy(1)
      expect(Change.where(recipient: "testRecipient@sheffield.ac.uk").count).to eq(0)

    end

  end


end

  
