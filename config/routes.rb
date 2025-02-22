Rails.application.routes.draw do
  resources :events do
    resources :comments, only: [:index, :create, :update, :destroy]
    resources :tickets, only: [:index, :create]
  end

  resources :favourites, only: [:create, :destroy]
end
