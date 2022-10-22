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
class UniModulesUser < ApplicationRecord
    belongs_to :user
    belongs_to :uni_module
    
    #self.table_name == "uni_modules_users"
    #self.primary_key = "user_id"
    #self.primary_key = "uni_module_id"

    validates_uniqueness_of :user_id, scope: :uni_module_id
end
