Rails.application.routes.draw do
  devise_for :users

  root to: 'tweets#index'
  resources :tweets
  resources :user, only: :show
  resources :operations , only: [:index,:edit]
end
