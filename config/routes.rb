Myflix::Application.routes.draw do

  get 'ui(/:action)', controller: 'ui'
  
  root to: "pages#front"

  get 'home', to: "videos#index"
  get 'my_queue', to: "queue_items#index"
  post 'update_queue', to: "queue_items#update_queue"
  get "people", to: "relationships#index"
  
  get "forgot_password", to: "forgot_passwords#new"
  resources :forgot_passwords, only: [:create]
  get "forgot_password_confirmation", to: "forgot_passwords#confirm"
  
  resources :password_resets, only: [:show, :create]

  get "expired_token", to: "password_resets#expired_token"

  resources :relationships, only: [:create, :destroy]
  resources :videos do 
    collection do
      get :search
    end
    member do
      post :add_to_queue
    end
  end
  resources :queue_items, only: [:create,:destroy]
  resources :reviews, only: [:create]
  resources :categories
  resources :users, only: [:create, :show]
  get "register/:token", to: "users#new_with_invitation_token", as: "register_with_token"
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"

  resources :sessions, only: [:create]

  resources :invitations, only: [:new, :create]

end
