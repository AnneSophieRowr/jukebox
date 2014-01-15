Jukebox::Application.routes.draw do

  devise_for :users

  root 'users#index'

  resources :users do 
   resources :playlists
  end

  resources :kinds do 
   resources :playlists
  end

  resources :playlists_songs

  resources :songs do
    get :play, on: :member
    collection do 
      get :search
    end
  end

  resources :playlists do
    member do 
      get :play
      get :manage
      get :add_song
      post :sort
    end
    collection do
      post :import
    end
  end

end
