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
FactoryBot.define do
  factory :change do
    recipient { "MyText" }
    sent { "MyText" }
  end
end
