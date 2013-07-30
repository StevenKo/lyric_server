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
          get 'album_songs'
          get 'top_list_songs'
          get 'recommend_songs'
        end
      end

      resources :singers, :only => [:index, :show] do
        collection do
          get 'hot_singers'
          get 'search'
          get 'all_hot_singers'
        end
      end

      resources :videos, :only => [:index]
      resources :singer_search_ways, :only => [:index]
      resources :singer_categories, :only => [:index]
      resources :singer_search_way_items, :only => [:index]

      resources :users, :only => [:create] do
        collection do
          put 'update_looked_songs'
          put 'update_looked_singers'
          put 'update_looked_albums'
          put 'update_collected_songs'
          put 'update_collected_albums'
          put 'update_collected_singers'
        end
      end

      resources :top_lists, :only => [:index]

    end
  end
end
