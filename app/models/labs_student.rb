# == Schema Information
#
# Table name: labs_students
#
#  lab_id     :bigint           not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_labs_students_on_lab_id_and_student_id  (lab_id,student_id)
#  index_labs_students_on_student_id_and_lab_id  (student_id,lab_id)
#
class LabsStudent < ApplicationRecord
    belongs_to :lab
    belongs_to :student

    validates_uniqueness_of :lab_id, scope: :student_id
    
end
