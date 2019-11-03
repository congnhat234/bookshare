Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }
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
  resources :posts
  get "/publish/:id", to: "posts#publish", as: "publish_post"
  get "/unpublish/:id", to: "posts#unpublish", as: "unpublish_post"
  resources :categories, only: %i(show)
  resources :users, only: %i(show)
  get "/:id/posts", to: "users#posts", as: "user_posts"
  get "/cart", to: "cart#index"
  post "/cart/add", to: "cart#add"
  delete "cart/remove/:id", to: "cart#remove", as: "cart_remove"
  put "cart/update/:id", to: "cart#update", as: "cart_update"
end
