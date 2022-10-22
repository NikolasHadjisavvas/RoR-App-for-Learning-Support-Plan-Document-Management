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
FactoryBot.define do
  factory :reminder do
    body { "MyText" }
    toAll { false }
  end
end
