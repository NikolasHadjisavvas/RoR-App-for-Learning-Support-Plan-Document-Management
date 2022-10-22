# == Schema Information
#
# Table name: labs
#
#  day        :text
#  eventId    :integer          primary key
#  finishdate :datetime
#  room       :text
#  roomname   :text
#  startdate  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
require 'rails_helper'

RSpec.describe Lab, type: :model do
end
