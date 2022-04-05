Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'tops#top'
  get 'rule', to: 'static_pages#rule'
  get 'privacy', to: 'static_pages#privacy'
  
  get 'login', to: 'user_sessions#new'
  delete 'logout', to: 'user_sessions#destroy'
  post 'login', to: 'user_sessions#create'
  

  resources :users, only: %i[new create edit update show ]
  resources :novels do
    resources :reviews, only: %i[create edit update destroy]
    resources :characters, only: %i[create update destroy], shallow: true
  end
end
