Rails.application.routes.draw do
  resources :lists do
    resources :cards
  end

  put '/cards/:id/change_list/:list_id', to: 'cards#change_list'
end
