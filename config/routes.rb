Jukebox::Application.routes.draw do
  resources :songs

  devise_for :users

  root 'users#index'

  resources :users, :kinds, :playlists

  resources :users do 
   resources :playlists
  end

  resources :kinds do 
   resources :playlists
  end

end
