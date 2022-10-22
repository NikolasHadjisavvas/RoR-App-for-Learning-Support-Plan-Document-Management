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
class Aea < ApplicationRecord
    self.primary_key = "regNo"
    belongs_to :student , optional: true

    validates :regNo, uniqueness: true, presence: true, length: {is: 9}

end
