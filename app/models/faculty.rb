# == Schema Information
#
# Table name: faculties
#
#  id         :bigint           not null, primary key
#  title      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Faculty < ApplicationRecord
    self.primary_key = 'id'
    has_many :departments 
    

    validates :title, uniqueness: true, presence: true
end
