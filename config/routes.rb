# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    resources :users
  end
  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get 'login' => 'v1/sessions#new'
  post 'login' => 'v1/sessions#create'
  delete 'logout' => 'v1/sessions#destroy'

  namespace :v1 do
    resources :sessions
    resources :requests
    resources :providers
    resources :provider_operations
    resources :orgnaizations
  end
  resources :users
  resources :dasbord
end
