require 'rails_helper'

RSpec.describe EventParticipant, type: :model do
  describe 'participants limit validation' do
    context 'when participants limit for the event is set' do
      it 'does not allow adding participants beyond the limit' do
        event = create(:event, participants_limit: 2)
        create(:event_participant, event:)
        create(:event_participant, event:)

        participant = build(:event_participant, event:)
        expect(participant).not_to be_valid
        expect(participant.errors[:base]).to include('Cannot add more participants, event limit reached')
      end
    end

    context 'when participants limit for the event is not set' do
      it 'allows adding participants without any limit' do
        event = create(:event, participants_limit: nil)

        20.times do
          create(:event_participant, event:)
        end

        participant = build(:event_participant, event:)
        expect(participant).to be_valid
      end
    end
  end

  describe 'participants uniqueness index' do
    let(:event) { create(:event) }
    let(:user) { create(:user) }

    context 'when duplicated event participant entry is being added' do
      it 'raises an error' do
        create(:event_participant, user:, event:)
        duplicate_participant = build(:event_participant, user:, event:)

        expect { duplicate_participant.save }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end
end
