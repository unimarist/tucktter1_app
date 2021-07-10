Rails.application.routes.draw do
  devise_for :users

  root to: 'tweets#index'
  resources :tweets do
    resources :comments, only: :create
  end
  resources :user, only: :show
  resources :operations , only: [:index,:edit]
  resources :researches 
end
