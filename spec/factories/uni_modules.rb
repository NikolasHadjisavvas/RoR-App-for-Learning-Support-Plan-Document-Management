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
FactoryBot.define do
  factory :uni_module do
    modCode { "MyText" }
    deptCode { "MyText" }
  end
end
