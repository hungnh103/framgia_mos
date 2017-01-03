Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions", registrations: "registrations",
    passwords: "passwords",
    omniauth_callbacks: "users/callbacks"},
    path: "", path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}

  root "static_pages#home"
  mount Ckeditor::Engine => "/ckeditor"
  mount ActionCable.server => "/cable"

  resources :posts
  resources :users, only: :show
  resources :likes, only: :create
  resources :categories, only: :show
  resources :confessions

  namespace :admin do
    root "statistics#index", as: :root
    delete "destroy_multi_post", to: "posts#destroy"
    delete "destroy_multi_category", to: "categories#destroy"
    delete "destroy_multi_advertisment", to: "advertisments#destroy"
    delete "destroy_multi_confession", to: "confessions#destroy"
    post "accept_post", to: "accept_post#update"
    resources :statistics, only: :index
    resources :categories
    resources :users, only: [:index, :update]
    resources :posts, except: :new
    resources :advertisments
    resources :confessions
    devise_for :users, controllers: {sessions: "admin/sessions"},
      path: "", path_names: {sign_in: "login", sign_out: "logout",
      sign_up: "register"}
  end
end
