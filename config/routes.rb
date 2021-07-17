Rails.application.routes.draw do
  devise_for :users

  root to: 'tweets#index'
  resources :tweets do
    resources :comments, only: :create
  end
  resources :user, only: :show
  resources :operations , only: [:index,:edit]
  resources :researches do
    resources :comments, only: :create
    collection do
      get 'my_research'
      get 'search'
      get 'my_search'
    end
  end
end
