Rails.application.routes.draw do
  devise_for :teams, controllers: {
    sessions:      'teams/sessions',
    passwords:     'teams/passwords',
    registrations: 'teams/registrations'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: "samples#index"
  resources :calendars
  resources :samples
  resources :users, only: [:show]
  resources :teams, only: [:show]
end
