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
require 'rails_helper'

RSpec.describe StudentsUniModule, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
