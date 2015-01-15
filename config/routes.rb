Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  resources :videos do 
    collection do
      get :search
    end
  end
  
  root :to => "videos#index"

  resources :categories


end
