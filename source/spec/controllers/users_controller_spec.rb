# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #events_participated' do
    let(:user) { create(:user, :with_3_events_participated) }

    it 'returns events participated by the user' do
      get :events_participated, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #events_organised' do
    let(:user) { create(:user, :with_3_events_organised) }

    it 'returns events organised by the user' do
      get :events_organised, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end
end
