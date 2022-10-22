# == Schema Information
#
# Table name: aeas
#
#  additional   :text
#  consent      :text
#  duration     :text
#  illness      :text
#  information  :text
#  other        :text
#  regNo        :text             primary key
#  requirements :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :aea do
    regNo { "MyText" }
    requirements { "MyText" }
    other { "MyText" }
    information { "MyText" }
    ilness { "MyText" }
    consent { "MyText" }
    duration { "MyText" }
    additional { "MyText" }
  end
end
