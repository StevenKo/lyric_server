require 'sidekiq/web'
LyricServer::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do

      resources :albums do
        collection do
          get 'hot_albums'
          get 'new_albums'
          get 'search'
        end
      end

      resources :songs do
        collection do
          get 'hot_songs'
          get 'search_name'
          get 'search_lyric'
        end
      end

      resources :singers, :only => [:index, :show] do
        collection do
          get 'hot_singers'
          get 'search'
        end
      end

      resources :videos, :only => [:index]
      resources :singer_search_ways, :only => [:index]
      resources :singer_categories, :only => [:index]
      resources :singer_search_way_items, :only => [:index]

    end
  end
end
