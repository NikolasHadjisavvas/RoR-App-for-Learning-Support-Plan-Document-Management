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
class UniModule < ApplicationRecord
    #self.primary_key = "modCode"
    has_many :uni_modules_users
    has_many :users, through: :uni_modules_users
    has_many :students_uni_modules
    has_many :students, through: :students_uni_modules
    has_many :labs_uni_modules
    has_many :labs, through: :labs_uni_modules
    belongs_to :department , optional: true

    validates :modCode, uniqueness: true, presence: true
    validates :deptCode, presence: true

    
end
