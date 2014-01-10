Jukebox::Application.routes.draw do

  devise_for :users

  root 'users#index'

  resources :users, :kinds, :playlists, :songs

  resources :users do 
   resources :playlists
  end

  resources :kinds do 
   resources :playlists
  end

  post 'songs/create'

end
