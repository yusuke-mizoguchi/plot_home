Rails.application.routes.draw do
  namespace :admin do
    get 'user_sessions/new'
  end
  namespace :admin do
    get 'dashboards/index'
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'tops#top'
  get 'rule', to: 'static_pages#rule'
  get 'privacy', to: 'static_pages#privacy'
  get 'about', to: 'static_pages#about'
  
  get 'login', to: 'user_sessions#new'
  delete 'logout', to: 'user_sessions#destroy'
  post 'login', to: 'user_sessions#create'
  

  resources :users, only: %i[new create edit update show ]
  resources :novels do
    resources :reviews, only: %i[create edit update destroy]
    resources :characters, only: %i[create update destroy], shallow: true
  end
  resources :password_resets, only: %i[new create edit update]

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index show edit update destroy]
    resources :novels, only: %i[index show edit update destroy]
    resources :reviews, only: %i[index show edit update destroy]
  end
end
