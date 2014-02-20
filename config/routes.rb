Jukebox::Application.routes.draw do

  devise_for :users

  root 'songs#index'

  get 'search', to: 'search#search', as: :search

  resources :artists, :playlists_songs, :albums_songs, :parameters, :types

  resources :records do
    collection do
      get :chart_data
    end
  end

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
    resources :records
    get :play, on: :member
    collection do 
      get :search
      post :import
    end
  end

  resources :playlists do
    resources :records
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
