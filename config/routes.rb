Rails.application.routes.draw do
  root 'tasks#index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'sessions/destroy'

  resources :users
  resources :tasks do
    resources :comments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
