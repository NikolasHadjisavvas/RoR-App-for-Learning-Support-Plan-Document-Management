# == Schema Information
#
# Table name: departments
#
#  deptCode   :text             primary key
#  deptTitle  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  faculty_id :bigint           not null
#
# Indexes
#
#  index_departments_on_faculty_id  (faculty_id)
#
# Foreign Keys
#
#  fk_rails_...  (faculty_id => faculties.id)
#
FactoryBot.define do
  factory :department do
    deptCode { "MyText" }
    deptTitle { "MyText" }
  end
end
