Rails.application.routes.draw do
  resources :lists do
    resources :cards
  end
end
