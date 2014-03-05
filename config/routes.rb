Jukebox::Application.routes.draw do

  devise_for :users

  root 'songs#index'

  get 'search', to: 'search#search', as: :search
  get 'synchronize', to: 'application#synchronize', as: :synchronize

  resources :records do
    collection do
      get :chart_data
    end
  end

  resources :artists, :types, :parameters

  resources :albums do
    member do
      get :manage
      get :add_song
      post :sort
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
    post :search, :import, on: :collection
  end

  resources :playlists do
    resources :records
    member do 
      get :play
      get :manage
      get :add_song
      post :sort
    end
  end

end
