# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions, only: :create
      resources :projects, only: :index, param: :title do
        resources :lists, only: %i[index create update] do
          resources :tasks, only: %i[create update]
        end
      end
    end
  end

  root to: 'home#index'
  get '/*path', to: 'home#index'
end
