Rails.application.routes.draw do
  devise_for :users,controllers: {   registrations: 'users/registrations',
    sessions: 'users/sessions' }
  
  root to: 'lp#index'
  resources :tweets do
    resources :comments,only: [:index,:create]
    resources :tweet_likes, only: [:index,:create,:destroy]
  end
  resources :user, only: :show
  resources :operations , only: [:index,:edit]
  resources :researches do
    resources :research_comments, only: [:index,:create]
    resources :research_likes, only: [:index,:create,:destroy]
    collection do
      get 'my_research'
      get 'search'
      get 'my_search'
    end
  end
end
