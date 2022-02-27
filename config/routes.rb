# frozen_string_literal: false

Rails.application.routes.draw do
  resources :auths, only: [:create]
  resources :kinds
  resources :contacts do
    resource :kind, only: [:show]
    resource :kind, only: [:show], path: 'relationships/kind'

    resource :phones, only: [:show]
    resource :phones, only: [:show], path: 'relationships/phones'
    resource :phone, only: [:update, :create, :destroy]
    resource :phone, only: [:update, :create, :destroy], path: 'relationships/phones'

    resource :address, only: [:show, :update, :create, :destroy]
    resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
  end

  # get '/contacts', to: "contacts#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

