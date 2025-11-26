Rails.application.routes.draw do
  # Devise routes for admin users (ActiveAdmin)
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise routes for regular users
  devise_for :users

  # Product and category resources
  resources :products, only: [:index, :show]   # add :new, :create, etc. if needed
  resources :categories, only: [:index, :show]

  # Static/dynamic pages (About, Contact, Shipping, Returns)
  # These will use the slug (e.g., /about, /contact)
  get "/:slug", to: "pages#show", as: :static_page

  # Root path
  root "products#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
