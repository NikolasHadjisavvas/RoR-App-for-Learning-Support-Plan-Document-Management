# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  current_sign_in_at :datetime
#  current_sign_in_ip :inet
#  dn                 :string
#  email              :string           default(""), not null
#  givenname          :string
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :inet
#  mail               :string
#  notification_freq  :integer          default(3)
#  ou                 :string
#  role               :string
#  sign_in_count      :integer          default(0), not null
#  sn                 :string
#  uid                :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
FactoryBot.define do
  factory :user do
    email { "my.email@sheffield.ac.uk" }
    givenname { "MyText" }
    sn { "MyText" }
    ou { "COM" }
  end
end
