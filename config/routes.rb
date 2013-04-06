require 'sidekiq/web'
LyricServer::Application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
end
