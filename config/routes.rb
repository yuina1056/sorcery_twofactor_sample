# frozen_string_literal: true

Rails.application.routes.draw do
  root 'users#index'
  resources :sessions
  resources :users
  resource :user_mfa_session, only: %i[new create]

  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
