Rails.application.routes.draw do
  resources :comments
  devise_for :users
  resources :links

  

  resources :links do
    
    member do
      get "like", :like_link_path
      get "dislike", :dislike_link_path
    end
  resources :comments
  end
  
  root 'links#index'
end
