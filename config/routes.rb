Rails.application.routes.draw do
  resources :games, only: [:new, :show, :create] do
    post :rematch, on: :member
    resources :moves, only: :create
  end

  root 'games#new'
end
