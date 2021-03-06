Rails.application.routes.draw do
  require "sidekiq/web"
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  mount Sidekiq::Web => "/sidekiq"
  mount Ckeditor::Engine => "/ckeditor"
  mount ActionCable.server => "/cable"
  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }
  devise_scope :user do
    match "timeout" => "users/sessions#timeout", via: :get
  end
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  post "/load-districts", to: "address#load_districts"
  post "/load-wards", to: "address#load_wards"
  get "/language", to: "static_pages#set_language"

  resources :books
  get "/share/books", to: "books#sharing", as: "sharing_books"
  get "/exchange/books", to: "books#exchange", as: "exchange_books"
  get "/selling/books", to: "books#selling", as: "selling_books"
  resources :posts
  get "/publish/:id", to: "posts#publish", as: "publish_post"
  get "/unpublish/:id", to: "posts#unpublish", as: "unpublish_post"
  resources :categories, only: %i(show)
  resources :users, only: %i(index show)
  get "/:id/user-posts", to: "users#posts", as: "user_posts"
  get "/:id/all-books", to: "users#books", as: "user_books"
  get "/cart", to: "cart#index"
  post "/cart/add", to: "cart#add"
  delete "cart/remove/:id", to: "cart#remove", as: "cart_remove"
  put "cart/update/:id", to: "cart#update", as: "cart_update"
  resources :relationships, only: %i(create destroy)
  resources :liked_posts, only: %i(create destroy)
  resources :orders
  resources :reviews, only: %i(create destroy)
  resources :comments, only: %i(create destroy)
  namespace :dashboard do
    resources :books
    resources :sharing_books, except: %i(show new edit)
    get "/sharing_books/requests", to: "sharing_books#request_book"
    post "/sharing_books/confirm/:id", to: "sharing_books#confirm"
    post "/sharing_books/reject/:id", to: "sharing_books#reject"
    post "/sharing_books/approve/:id", to: "sharing_books#approve"
    post "/sharing_books/done/:id", to: "sharing_books#done"
    resources :exchange_books, except: %i(show new edit)
    get "/exchange_books/requests", to: "exchange_books#request_book"
    post "/exchange_books/confirm/:id", to: "exchange_books#confirm"
    post "/exchange_books/reject/:id", to: "exchange_books#reject"
    post "/exchange_books/approve/:id", to: "exchange_books#approve"
    post "/exchange_books/done/:id", to: "exchange_books#done"
    resources :conversations, only: %i(create index)
    resources :messages, only: :create
    resources :orders
    get "/user-orders", to: "orders#user_order"
    post "/orders/processing/:id", to: "orders#processing"
    post "/orders/cancel/:id", to: "orders#cancel"
    post "/orders/done/:id", to: "orders#done"
  end
  resources :notifications, only: %i(index update)

  namespace :admins do
    get "/", to: "home#index"
    resources :books
    post "/books/active", to: "books#active"
    post "/books/inactive", to: "books#inactive"
    resources :posts
    post "/posts/publish", to: "posts#publish"
    post "/posts/unpublish", to: "posts#unpublish"
    post "/posts/classify", to: "posts#auto_classify"
    resources :users
    resources :categories
  end
  resources :search, only: :index
  get "/search-posts", to: "search#index_post"
end
