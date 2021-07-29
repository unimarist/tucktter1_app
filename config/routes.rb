Rails.application.routes.draw do
  devise_for :users,controllers: {   registrations: 'users/registrations',
    sessions: 'users/sessions' }
  
  root to: 'lp#index'
  resources :tweets do
    resources :comments,only: [:index,:create] do
    end
      resources :tweet_likes, only: [:index,:create,:destroy]
  end
  resources :user,only: [:show,:edit,:update] do
    resources :chat_room, only: [:new,:create] do
      resources :chats, only: [:index, :create]
    end
  end
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
