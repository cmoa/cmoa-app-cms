CMOA::Application.routes.draw do
  # CMS
  resources :exhibitions do
    get :positions, :on => :collection


    resources :artists do
      resources :links do
        get :positions, :on => :collection
      end
    end



    resources :artworks, :path => '/artwork' do
      resources :media do
        get :positions, :on => :collection
      end

      resources :artist_artworks, :path => '/artist'
    end

    resources :tours do
      resource :tour_artwork, :path => '/artwork'
    end
  end


resources :beacons do
    get :detach
end

resources :locations
resources :categories
resources :feeds
resources :hours


  # API 1.0
  scope '/api' do
    match 'sync'      => 'api_v1#sync',          :as => 'api_sync',         via: [:get, :post]
    match 'like'      => 'api_v1#like',          :as => 'api_like',         via: [:get, :post]
    match 'subscribe' => 'api_v1#subscribe',     :as => 'api_subscribe',    via: [:get, :post]
    match 'hours'     => 'api_v1#hours',         :as => 'api_hours',        via: [:get, :post]
  end

  # API 2.0
  scope '/api/v2' do
    match 'sync'      => 'api_v2#sync',          :as => 'api_sync_v2',      via: [:get, :post]
    match 'like'      => 'api_v2#like',          :as => 'api_like_v2',      via: [:get, :post]
    match 'subscribe' => 'api_v2#subscribe',     :as => 'api_subscribe_v2', via: [:get, :post]
    match 'hours'     => 'api_v2#hours',         :as => 'api_hours_v2',     via: [:get, :post]
  end

  # Base
  devise_for :admins
  resources :admins, only: [:index, :new, :create, :destroy]

  #profile edit for admins
  scope '/' do
    match 'profile' => 'admins#profile',       :as => 'admin_profile', via: [:get]
    match 'profile' => 'admins#save_profile',  :as => 'admin_save_profile', via: [:post, :patch]
  end

  #Error codes
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#server_error", :via => :all
  match "/413", :to => "errors#request_too_large", :via => :all

  root 'dashboard#index'
end
