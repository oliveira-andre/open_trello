# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :lists, only: %i[index show]
    end
  end

  root to: 'home#index'
end
