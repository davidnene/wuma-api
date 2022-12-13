Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/login' => 'auth#login'
  get '/me', to: 'users#show_me'
  put '/profile/update', to: 'profiles#update_profile'
  post '/signup', to: 'users#create'
end
