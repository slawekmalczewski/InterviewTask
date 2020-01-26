Rails.application.routes.draw do
  resources :clients
  resources :messages

  get 'search',to:"messages#search"
  get 'search_range',to:"messages#search_range"

  root :to => 'messages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
