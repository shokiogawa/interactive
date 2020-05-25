Rails.application.routes.draw do

  get 'comments/create'
  get 'comments/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'posts/show'
  get 'posts/new'
  get 'posts/create'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'toppages#index'
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  resources :users do
    member do
     get :followings
     get :followers
    end
   end
   
  resources :posts
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [ :create, :destroy]
  
end
