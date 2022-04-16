Rails.application.routes.draw do
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
end
