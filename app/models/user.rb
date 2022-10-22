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
class User < ApplicationRecord
  include EpiCas::DeviseHelper

  ##
  # Parameters filled in using the ldap lookup for a user
  #
  def generate_attributes_from_ldap_info
    self.username = self.uid
    self.email = self.mail
    self.givenname = self.givenname
    self.sn = self.sn
    super
  end
  
  has_many :uni_modules_users
  has_many :uni_modules, through: :uni_modules_users
  has_many :students_users
  has_many :students, through: :students_users
  has_many :labs
  belongs_to :department, optional: true
  has_and_belongs_to_many :reminders

  validates :ou, :givenname, :sn, presence: true
  validates :email, uniqueness: true, presence: true
  validates :ou, length: { is: 3 }
  validates :email, length: {maximum: 50 }

  ##
  # Checks if the role of a user is an superuser.
  #
  # @returns Boolean
  #
  def superuser?
    role == 'Superuser'
  end

  ##
  # Checks if the role of a user is an academic.
  #
  # @returns Boolean
  #
  def academic?
    role == 'Academic'
  end

  ##
  # Checks if the role of a user is an lab technician.
  #
  # @returns Boolean
  #
  def lab_technician?
    role == 'Lab Technician'
  end

  ##
  # Checks if the role of a user is an ddss.
  #
  # @returns Boolean
  #
  def ddss?
    role == 'DDSS'
  end

  ##
  # Checks if the role of a user is an dlo.
  #
  # @returns Boolean
  #
  def dlo?
    role == "DLO"
  end

  ##
  # Used to retrieve the full name of a user
  #
  # @return String
  #
  def fullName
    "#{givenname} #{sn}"
  end
  
end
