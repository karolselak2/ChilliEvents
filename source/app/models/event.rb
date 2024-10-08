class Event < ApplicationRecord
  has_many :event_participants
  has_many :participants, through: :event_participants, source: :user
  belongs_to :organiser, class_name: 'User', foreign_key: 'organiser_id'
end
