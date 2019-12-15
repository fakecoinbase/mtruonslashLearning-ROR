Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # Adding a route for a article
  resources :articles do
    resources :comments
  end

  root 'articles#index'
end
