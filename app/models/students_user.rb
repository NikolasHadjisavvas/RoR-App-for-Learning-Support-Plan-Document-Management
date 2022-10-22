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
class StudentsUser < ApplicationRecord
    belongs_to :student
    belongs_to :user

    validates_uniqueness_of :student_id, scope: :user_id
end
