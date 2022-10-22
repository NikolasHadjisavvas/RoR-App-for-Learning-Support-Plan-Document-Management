# == Schema Information
#
# Table name: labs
#
#  day        :text
#  eventId    :integer          primary key
#  finishdate :datetime
#  room       :text
#  roomname   :text
#  startdate  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
class Lab < ApplicationRecord
    self.primary_key = "eventId"
    has_many :labs_students
    has_many :students, through: :labs_students
    has_many :labs_uni_modules
    has_many :uni_modules, through: :labs_uni_modules
    belongs_to :user

    validates :eventId, uniqueness: true, presence: true
    attr_accessor :start_time
    attr_accessor :finish_time
    attr_accessor :date
    validate :finishdate_after_startdate?

    def finishdate_after_startdate?
        if finishdate <= startdate
            errors.add :finishdate, "must be after start date"
        end
    end
end
