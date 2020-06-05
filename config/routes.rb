Rails.application.routes.draw do

  
 
 
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'users#index'
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users do
    member do
     get :followings
     get :followers
     get :recomends
    end
   end
   
  resources :posts do
   resources :comments, only: [ :create, :destroy]
  end
  
    
  resources :relationships, only: [:create, :destroy]
  
  
end
