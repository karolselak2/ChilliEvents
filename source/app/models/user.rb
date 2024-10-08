class User < ApplicationRecord
  has_many :event_participants
  has_many :events_participated, through: :event_participants, source: :event
  has_many :events_organised, class_name: 'Event', foreign_key: 'organiser_id'
end
