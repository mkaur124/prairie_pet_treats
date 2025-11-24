Rails.application.routes.draw do
  # Devise routes for admin users (ActiveAdmin)
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise routes for regular users
  devise_for :users

  # Route for static/dynamic pages (like About, Contact)
  resources :pages, only: [:show]

  # Root path of your site
  root "products#index"

  # Health check endpoint for uptime monitoring
  get "up" => "rails/health#show", as: :rails_health_check

  # Optional PWA routes (uncomment if you implement PWA)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
