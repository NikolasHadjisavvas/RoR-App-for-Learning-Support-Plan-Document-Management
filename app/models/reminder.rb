# == Schema Information
#
# Table name: reminders
#
#  id         :bigint           not null, primary key
#  body       :text
#  toAll      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Reminder < ApplicationRecord
    has_and_belongs_to_many :users

    validates :body, presence: true

end
