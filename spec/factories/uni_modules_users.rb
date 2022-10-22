# == Schema Information
#
# Table name: uni_modules_users
#
#  uni_module_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_uni_modules_users_on_uni_module_id_and_user_id  (uni_module_id,user_id) UNIQUE
#  index_uni_modules_users_on_user_id_and_uni_module_id  (user_id,uni_module_id) UNIQUE
#
FactoryBot.define do
  factory :uni_modules_user do
    
  end
end
