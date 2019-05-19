# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :votes, only: %i[index show create]
      resources :posts, only: %i[index show]
      resources :subscribers, only: %i[index show create update]
      resources :images, only: %i[index show]
      # resources :images, only: %i[create update], constraints: { subdomain: 'admin' }
      # post :invite, to: 'invite#send'
    end
  end

  resources :posts, only: %i[index show]
  # resources :weekly_reports, only: %i[index show]
  # get 'subscribe', to: 'subscribe#index'

  # root 'home#index'
  # get '*path', to: redirect('')
end
