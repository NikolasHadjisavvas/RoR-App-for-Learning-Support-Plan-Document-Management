# Student model
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
require 'date'

class Student < ApplicationRecord
    #setting the associations for students.
    self.primary_key = "regNo"
    has_many :students_users
    has_many :users, through: :students_users
    has_many :students_uni_modules
    has_many :uni_modules, through: :students_uni_modules
    has_many :labs_students
    has_many :labs, through: :labs_students
    belongs_to :department, optional: true

    #setting the validations for students
    validates :deptCode, :periodOfStudy, :personalTutor, :programmeCode, presence: true
    validates :regNo, uniqueness: true, presence: true, length: { is: 9 }
    validates :deptCode, length: { is: 3 }
    validates :programmeCode, length: { maximum: 7 }


    ##
    # Used to retrieve the full name of a student
    #
    # @return String
    #
    def fullName
        "#{firstname} #{lastname}"
    end

    def self.delete_graduated_students
        students = Student.all
        current_date = Time.now
        expired_students = Array.new

        students.each do |student|
            completion_date_plus_1 = DateTime.new(student.completion_date.year+1, student.completion_date.month, student.completion_date.day)
            if current_date > completion_date_plus_1 then
                expired_students.append(student)
                Student.find_by(regNo: student.id).destroy
            end
        end
    end  


end
