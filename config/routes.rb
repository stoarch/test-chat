Rails.application.routes.draw do
  root "chats#index"

  resources :chats, only: [:index, :new, :create, :show] do
    resources :messages, only: [:create]
  end

  get 'login', to: 'sessions#new', as: 'new_user_session'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
