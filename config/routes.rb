Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post  "/login"    => 'aio#login'
  get   "/wallet"   => 'aio#wallet'
  post  "/deposit"  => 'aio#deposit'
  post  "/withdraw" => 'aio#withdraw'
  post  "/transfer" => 'aio#transfer'
end
