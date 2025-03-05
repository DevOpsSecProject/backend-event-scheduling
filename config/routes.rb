Rails.application.routes.draw do
  # Routes for Events (CRUD)
  resources :events, only: [:index,:show, :create, :update, :destroy] do
    # Nested routes for Attendees (CRUD)
    resources :attendees, only: [:index, :create, :update, :destroy]

    resources :comments, only: [:index, :create, :update, :destroy]
    resources :tickets, only: [:index, :create, :update, :destroy]
  end

  # RSVP functionality (custom route for attendees)
  resources :attendees do
    member do
      post :rsvp
    end
  end
  resources :users do
    resources :favourites, only: [:index]
  end

  resources :favourites, only: [:create, :destroy]
  resources :tickets, only: [:update]
end
