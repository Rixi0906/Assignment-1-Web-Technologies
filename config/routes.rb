Rails.application.routes.draw do
  # Root
  root "pages#home"

  # Static pages
  get "/about", to: "pages#about"
  get "/contact", to: "pages#contact"

  # Authentication
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Registration (user signup)
  get "/register", to: "registrations#new"
  post "/register", to: "registrations#create"

  # Cart
  get "/cart", to: "carts#show"

  # Core resources
  resources :products, only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :cart_items, only: [:create, :update, :destroy]

  # Optional: password reset routes
  resources :password_resets, only: [:new, :create, :edit, :update]
end
