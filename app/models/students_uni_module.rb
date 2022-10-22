# == Schema Information
#
# Table name: students_uni_modules
#
#  student_id    :bigint           not null
#  uni_module_id :bigint           not null
#
# Indexes
#
#  index_students_uni_modules_on_student_id_and_uni_module_id  (student_id,uni_module_id) UNIQUE
#  index_students_uni_modules_on_uni_module_id_and_student_id  (uni_module_id,student_id) UNIQUE
#
class StudentsUniModule < ApplicationRecord
    belongs_to :student
    belongs_to :uni_module

    validates_uniqueness_of :student_id, scope: :uni_module_id

    #self.table_name = 'students_uni_modules'
    #self.primary_key = "student_id"
    #self.primary_key = "uni_module_id"
    
end
