require 'rails_helper'

RSpec.describe EventParticipant, type: :model do
  describe 'participants limit validation' do
    describe 'when participants limit for the event is set' do
      it 'does not allow adding participants beyond the limit' do
        event = create(:event, participants_limit: 2)
        create(:event_participant, event: event)
        create(:event_participant, event: event)

        participant = build(:event_participant, event: event)
        expect(participant).not_to be_valid
        expect(participant.errors[:base]).to include('Cannot add more participants, event limit reached')
      end
    end

    describe 'when participants limit for the event is not set' do
      it 'allows adding participants without any limit' do
        event = create(:event, participants_limit: nil)

        20.times do
          create(:event_participant, event: event)
        end

        participant = build(:event_participant, event: event)
        expect(participant).to be_valid
      end
    end
  end
end