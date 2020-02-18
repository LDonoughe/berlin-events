# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :event, only: [:index]

  post 'event', to: 'event#index' # not very restful but avoids using javascript/query params for now
end
