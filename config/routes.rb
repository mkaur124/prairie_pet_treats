Rails.application.routes.draw do
  get "webhooks/stripe"
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :orders, only: [:index, :show]

  get    '/cart',                     to: 'carts#show', as: 'cart'
  post   '/cart/add',                 to: 'carts#add', as: 'cart_add'
  post   '/cart/update',              to: 'carts#update', as: 'cart_update'
  delete '/cart/remove/:product_id',  to: 'carts#remove', as: 'cart_remove'

  get  '/checkout/new',      to: 'checkouts#new',    as: 'new_checkout'
  post '/checkout',          to: 'checkouts#create', as: 'checkout'
  get '/checkout/invoice/:order_id', to: 'checkouts#invoice', as: 'checkout_invoice'

  post '/checkout/fake_payment', to: 'checkouts#fake_payment', as: 'fake_payment'

  root "products#index"

  get "/:slug", to: "pages#show", as: :static_page

  get "up" => "rails/health#show", as: :rails_health_check
end
