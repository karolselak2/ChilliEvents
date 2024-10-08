require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#participants' do
    context 'when participants are assigned to the event' do
      it 'returns the participants' do
        event = create(:event)
        participant1 = create(:user)
        participant2 = create(:user)

        event.event_participants.create(user: participant1)
        event.event_participants.create(user: participant2)

        expect(event.participants).to match_array([participant1, participant2])
      end
    end
  end

  describe '#organiser' do
    context 'when an organiser is assigned to the event' do
      it 'returns the organiser' do
        organiser = create(:user)
        event = create(:event, organiser:)

        expect(event.organiser).to eq(organiser)
      end
    end
  end
end
