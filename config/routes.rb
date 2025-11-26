Rails.application.routes.draw do
  # Devise routes for admin users (ActiveAdmin)
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise routes for regular users
  devise_for :users

  # Product and category resources
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]

  # Shopping cart routes
  get    '/cart',           to: 'carts#show'
  post   '/cart/add',       to: 'carts#add'
  post   '/cart/update',    to: 'carts#update'
  delete '/cart/remove/:product_id', to: 'carts#remove', as: 'cart_remove'

  # Checkout routes
get  '/checkout/new',      to: 'checkouts#new',    as: 'new_checkout'
post '/checkout',          to: 'checkouts#create', as: 'checkout'
get  '/checkout/invoice',  to: 'checkouts#invoice', as: 'checkout_invoice'


  # Static/dynamic pages
  get "/:slug", to: "pages#show", as: :static_page

  # Root path
  root "products#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
