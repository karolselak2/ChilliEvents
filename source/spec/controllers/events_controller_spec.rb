# spec/controllers/events_controller_spec.rb

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event, :with_3_participants) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new event' do
        event_params = {
          name: 'New Event',
          organiser_id: user.id,
          start: Time.now,
          end: Time.now + 1.day,
          participants_limit: 10
        }

        expect do
          post :create, params: { event: event_params }
        end.to change(Event, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'does not create a new event' do
        expect do
          post :create, params: { event: { name: nil } }
        end.to change(Event, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    it 'returns the requested event' do
      get :show, params: { id: event.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['id']).to eq(event.id)
    end
  end

  describe 'GET #participants' do
    it 'returns the participants of the event' do
      get :participants, params: { event_id: event.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3) # Expecting three participants
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested event' do
        patch :update, params: { id: event.id, event: { name: 'Updated Event' } }
        event.reload
        expect(event.name).to eq('Updated Event')
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid params' do
      it 'does not update the event' do
        patch :update, params: { id: event.id, event: { name: nil } }
        event.reload
        expect(event.name).not_to be_nil
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #register_participant' do
    context 'when the user registers successfully' do
      it 'creates a new event participant' do
        event # avoid late initialization
        expect {
          post :register_participant, params: { event_id: event.id, user_id: user.id }
        }.to change(EventParticipant, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['user_id']).to eq(user.id)
        expect(JSON.parse(response.body)['event_id']).to eq(event.id)
      end
    end

    context 'when the user tries to register for the same event again' do
      before do
        create(:event_participant, user: user, event: event)
      end

      it 'does not create a new event participant' do
        expect {
          post :register_participant, params: { event_id: event.id, user_id: user.id }
        }.to change(EventParticipant, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the event has reached its participant limit' do
      let(:event) { create(:event, :with_3_participants, participants_limit: 3) }

      it 'does not allow the user to register' do
        event # avoid late initialization
        expect {
          post :register_participant, params: { event_id: event.id, user_id: user.id }
        }.to change(EventParticipant, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
