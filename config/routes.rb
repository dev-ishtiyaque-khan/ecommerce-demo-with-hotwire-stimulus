Rails.application.routes.draw do
  get 'static_pages/about_us'
  get 'static_pages/contact_us'
  get 'static_pages/home'

  resources :products, only: %i[index show] do
    resources :reviews, only: %i[create new]
  end

  resource :carts, only: %i[create show] do
    post 'destroy_item/:item_id', on: :member, action: :destroy_item, as: :destroy_item
    patch 'update_quantity/:item_id', on: :member, action: :update_quantity, as: :update_quantity
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'static_pages#home'
end
