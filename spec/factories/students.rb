# == Schema Information
#
# Table name: students
#
#  completion_date :date
#  deptCode        :text
#  email           :text
#  firstname       :text
#  lastname        :text
#  periodOfStudy   :text
#  personalTutor   :text
#  programmeCode   :text
#  regNo           :integer          primary key
#  sup_email       :text
#  supervisor      :text
#  tut_email       :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  sup_id          :integer
#  tutor_id        :integer
#
FactoryBot.define do
  factory :student do
    sequence :regNo, 200000001 do |n|
      "#{n}".to_i
    end
    programmeCode { "COMU01" }
    deptCode { "COM" }
    personalTutor { "MyText" }
    periodOfStudy { "A" }
  end
end
