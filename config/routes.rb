Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :comments, :except => [:show]

  devise_for :users

  root to: "posts#index"
end
