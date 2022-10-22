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
class Department < ApplicationRecord
    self.primary_key = "deptCode"
    has_many :students
    has_many :users
    has_many :uni_modules
    belongs_to :faculty, optional: true

    validates :deptCode, uniqueness: true, presence: true, length: {is: 3}
    validates :deptTitle, presence: true


    def codeAndTitle
        "#{deptCode} - #{deptTitle}"
    end


end
