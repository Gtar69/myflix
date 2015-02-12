Myflix::Application.routes.draw do

  get 'ui(/:action)', controller: 'ui'
  
  root to: "pages#front"
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"
  get 'home', to: "videos#index"
  get 'my_queue', to: "queue_items#index"
  post 'update_queue', to: "queue_items#update_queue"

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
  resources :sessions, only: [:create]
end
