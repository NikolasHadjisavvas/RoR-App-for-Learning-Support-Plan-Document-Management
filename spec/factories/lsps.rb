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
FactoryBot.define do
  factory :lsp do
    access { "MyText" }
    contact { "MyText" }
    teaching { "MyText" }
    exams { "MyText" }
    practicals { "MyText" }
    circumstances { "MyText" }
    recommendations { "MyText" }
  end
end
