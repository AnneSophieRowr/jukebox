Jukebox::Application.routes.draw do

  devise_for :users

  root 'songs#index'

  resources :artists, :playlists_songs, :albums_songs, :parameters, :types

  resources :albums do
    member do
      get :manage
      get :add_song
      post :sort
    end
    collection do
      post :import
    end
  end

  resources :users do 
   resources :playlists
  end

  resources :kinds do 
   resources :playlists
  end


  resources :songs do
    get :play, on: :member
    collection do 
      get :search
      post :import
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
