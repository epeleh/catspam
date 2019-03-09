# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # resources :votes, only: %i[show create]
      # resources :posts, only: %i[index show]
      # resources :subscribers, only: %i[index show create update]
      # resources :images, only: %i[index show]
      # resources :images, only: %i[create update], constraints: { subdomain: 'admin' }
      # post :invite, to: 'invite#create', constraints: { subdomain: 'admin' }
    end
  end

  # root 'home#index'
  # get 'weekly-report/:id', to: 'weekly-report#show'
  # get 'subscribe', to: 'subscribe#index'
  # get '*path', to: 'home#index'
end
