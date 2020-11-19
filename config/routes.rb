Rails.application.routes.draw do
  devise_for :teams, controllers: {
    sessions:      'teams/sessions',
    passwords:     'teams/passwords',
    registrations: 'teams/registrations'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  root to: "calendars#index"
end
