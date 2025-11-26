Rails.application.routes.draw do
  # Devise authentication (login, logout, register, password recovery, etc.)
  # If you later add Users::SessionsController to merge guest cart, change to:
  # devise_for :users, controllers: { sessions: "users/sessions" }
  devise_for :users

  # Root
  root "pages#home"

  # Static pages
  get "/about",   to: "pages#about"
  get "/contact", to: "pages#contact"

  # Cart
  get "/cart", to: "carts#show"
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Core resources
  resources :products do
  # Admin will manage sizes/prices/stocks here
    resources :product_variants, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :orders,   only: [:index, :show]
  resources :cart_items, only: [:create, :update, :destroy]
end
