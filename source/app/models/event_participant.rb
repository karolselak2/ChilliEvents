class EventParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validate :participants_limit_not_exceeded

  private

  def participants_limit_not_exceeded
    event = Event.includes(:participants).find(self.event_id)

    if event&.participants_limit && (event.participants.size >= event.participants_limit)
      errors.add(:base, 'Cannot add more participants, event limit reached')
    end
  end
end
