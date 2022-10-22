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
FactoryBot.define do
  factory :lab do
    eventId { 1 }
    start { "MyText" }
    finish { "MyText" }
    day { "MyText" }
    room { "MyText" }
    roomname { "MyText" }
    date { "2021-04-18 00:05:56" }
  end
end
