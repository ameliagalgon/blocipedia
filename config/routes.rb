Rails.application.routes.draw do

  resources :wikis
  resources :charges, only: [:new, :create, :destroy]
  resources :collaborators, only: [:create, :destroy]

  devise_for :users
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
