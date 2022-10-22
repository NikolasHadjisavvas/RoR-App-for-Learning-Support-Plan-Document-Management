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
require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe '#fullName' do
    it 'returns the concatenation of the firstname and surname' do
      user = User.new(email: 'my.email@sheffield.ac.uk', givenname: 'My', sn: 'Email')
      expect(user.fullName).to eq 'My Email'
    end
  end

  describe '#superuser?' do
    it 'returns true if the user has the superuser role' do
      user = create(:user, role: 'Superuser')
      expect(user.superuser?).to eq true
    end

    it 'returns false if the user does not have the superuser role' do
      user = create(:user, role: 'DLO')
      expect(user.superuser?).to eq false
    end
  end

  describe '#dlo?' do
    it 'returns true if the user has the dlo role' do
      user = user = create(:user, role: 'DLO')
      expect(user.dlo?).to eq true
    end

    it 'returns false if the user does not have the dlo role' do
      user = create(:user, role: 'Superuser')
      expect(user.dlo?).to eq false
    end
  end


  describe '#ddss?' do
    it 'returns true if the user has the ddss role' do
      user = create(:user, role: 'DDSS')
      expect(user.ddss?).to eq true
    end

    it 'returns false if the user does not have the ddss role' do
      user = create(:user, role: 'Superuser')
      expect(user.ddss?).to eq false
    end
  end


  describe '#academic?' do
    it 'returns true if the user has the academic role' do
      user = create(:user, role: 'Academic')
      expect(user.academic?).to eq true
    end

    it 'returns false if the user does not have the academic role' do
      user = create(:user, role: 'Superuser')
      expect(user.academic?).to eq false
    end
  end


  describe '#lab_technician?' do
    it 'returns true if the user has the lab technician role' do
      user = create(:user, role: 'Lab Technician')
      expect(user.lab_technician?).to eq true
    end

    it 'returns false if the user does not have the lab technician role' do
      user = create(:user, role: 'Superuser')
      expect(user.lab_technician?).to eq false
    end
  end

end
