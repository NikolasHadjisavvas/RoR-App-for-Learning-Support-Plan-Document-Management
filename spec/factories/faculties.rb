# == Schema Information
#
# Table name: faculties
#
#  id         :bigint           not null, primary key
#  title      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :faculty do
    title { "MyText" }
  end
end
