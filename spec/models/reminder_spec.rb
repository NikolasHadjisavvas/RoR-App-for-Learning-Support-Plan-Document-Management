# == Schema Information
#
# Table name: reminders
#
#  id         :bigint           not null, primary key
#  body       :text
#  toAll      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Reminder, type: :model do

  describe '#new' do 
    it 'creates a reminder record' do

      reminder = Reminder.new(id:1, body:"test body")
      expect(reminder.save!).to eq true

    end

    it 'refuses to create a reminder record with no body' do

      reminder = Reminder.new(id:1, body:nil)
      expect(reminder.valid?).to eq false

    end

  end

  describe '#destroy' do
    it 'destroys a reminder record' do

      reminder = Reminder.create(id: 1,body: "test body", toAll: 'False')
      Reminder.destroy(1)
      expect(Reminder.where(id: 1).count).to eq(0)

    end

end

end
