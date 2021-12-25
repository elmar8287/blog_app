Rails.application.routes.draw do
  devise_for :users,
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
get '/member-data', to: 'members#show'
  resources :users, only: [:index, :show] do 
    resources :posts, only: [:index, :show]
  end
  get '/create_post', to: 'posts#create_post'
  post '/create', to: 'posts#create'
  post '/users/:user_id/posts/:post_id/create', to: 'comments#create'
  post '/like/create', to: 'likes#create'
  root 'users#index'


  namespace :api do
      resources :posts, only: %i[index show new create destroy] do
        resources :comments, only: %i[index new create destroy]
    end
  end
end
