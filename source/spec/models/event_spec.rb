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

  describe 'name validation' do
    let(:user) { create(:user) }

    context 'when a name is a string' do
      it 'is valid' do
        event = Event.new(name: 'Test Event', organiser: user)
        expect(event).to be_valid
      end
    end

    context 'when name is not given' do
      it 'is invalid' do
        event = Event.new(name: nil, organiser: user)
        expect(event).not_to be_valid
        expect(event.errors[:name]).to include("can't be blank")
      end
    end
  end
end
