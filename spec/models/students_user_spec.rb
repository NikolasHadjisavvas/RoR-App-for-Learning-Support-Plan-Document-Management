# == Schema Information
#
# Table name: students_users
#
#  student_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_students_users_on_student_id_and_user_id  (student_id,user_id)
#  index_students_users_on_user_id_and_student_id  (user_id,student_id)
#
require 'rails_helper'

RSpec.describe StudentsUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
