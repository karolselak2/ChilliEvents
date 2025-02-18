require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#events_organised' do
    context 'when the user is the organiser of events' do
      it 'returns the events organised by the user' do
        organiser = create(:user)
        event1 = create(:event, organiser:)
        event2 = create(:event, organiser:)

        expect(organiser.events_organised).to match_array([event1, event2])
      end
    end
  end

  describe '#events_participated' do
    context 'when the user is a participant in events' do
      it 'returns the events the user participated in' do
        user = create(:user)
        event1 = create(:event)
        event2 = create(:event)

        event1.event_participants.create(user:)
        event2.event_participants.create(user:)

        expect(user.events_participated).to match_array([event1, event2])
      end
    end
  end
end
