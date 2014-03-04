Jukebox::Application.routes.draw do

  devise_for :users

  root 'songs#index'

  get 'search', to: 'search#search', as: :search

  resources :records do
    collection do
      get :chart_data
    end
  end

  concern :synchronizable do
    get :synchronize, on: :collection
  end

  resources :artists, :types, concerns: :synchronizable

  resources :albums, concerns: :synchronizable do
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

  resources :kinds, concerns: :synchronizable do 
   resources :playlists
  end


  resources :songs, concerns: :synchronizable do
    resources :records
    get :play, on: :member
    collection do 
      get :search
      post :import
    end
  end

  resources :playlists, concerns: :synchronizable do
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
