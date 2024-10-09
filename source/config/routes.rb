Rails.application.routes.draw do
  resources :events do
    get 'participants', to: 'events#participants'
    post 'register_participant', to: 'events#register_participant'
  end

  resources :users do
    get 'events_participated', to: 'users#events_participated'
    get 'events_organised', to: 'users#events_organised'
  end
end
