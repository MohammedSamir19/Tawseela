Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'
  # Sidekiq::Web.set :sessions, false
  # Sidekiq::Web.set :session_secret, Rails.configuration.secret_token
  # Sidekiq::Web.use(::Rack::Protection, { use: :authenticity_token, logging: true, message: "Didn't work!" })

  resources :trips do
    resources :locations
  end
end
