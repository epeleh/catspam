# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # resources :images, only: %i[create update], constraints: { subdomain: 'admin' }
      resources :images, only: %i[index show]
      resources :posts, only: %i[index show]
      resources :reports, only: %i[index show]
      resources :subscribers, only: %i[index show create update]
      resources :votes, only: %i[index show create]
      # post :invite, to: 'invite#send'
    end
  end

  resources :posts, only: %i[show]
  resources :reports, only: %i[show]
  # get 'subscribe', to: 'subscribe#index'
  # get 'invite', to: 'invite#index'

  root 'home#index'
  get '*path', to: redirect('')
end
