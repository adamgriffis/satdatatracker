Rails.application.routes.draw do
    root 'welcome#index'

    mount SatelliteTrackerApi::ApiV1 => '/'

    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
end
