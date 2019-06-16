# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :images, only: %i[index show]
      # resources :images, only: %i[create update destroy], constraints: { subdomain: 'admin' }

      resources :messages, only: %i[index show]
      # resources :messages, only: %i[create update destroy], constraints: { subdomain: 'admin' }

      resources :posts, only: %i[index show]
      resources :reports, only: %i[index show]

      resources :subscribers, only: %i[index show create update]
      resources :votes, only: %i[index show create]
    end
  end

  resources :posts, only: %i[show]
  resources :reports, only: %i[show]

  get 'invite', to: 'invite#index'

  root 'home#index'
  get '*path', to: redirect('')
end
