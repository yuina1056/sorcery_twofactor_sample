Rails.application.routes.draw do
  root :to => 'users#index'
  resources :sessions
  resources :users

  get 'login' => 'sessions#new', :as => :login
  post 'logout' => 'sessions#destroy', :as => :logout

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
