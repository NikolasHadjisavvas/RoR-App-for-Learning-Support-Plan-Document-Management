# == Schema Information
#
# Table name: labs_uni_modules
#
#  lab_id        :bigint           not null
#  uni_module_id :bigint           not null
#
# Indexes
#
#  index_labs_uni_modules_on_lab_id_and_uni_module_id  (lab_id,uni_module_id) UNIQUE
#  index_labs_uni_modules_on_uni_module_id_and_lab_id  (uni_module_id,lab_id) UNIQUE
#
class LabsUniModule < ApplicationRecord
    belongs_to :lab
    belongs_to :uni_module

    validates_uniqueness_of :lab_id, scope: :uni_module_id
    
end
