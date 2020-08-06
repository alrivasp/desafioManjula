Rails.application.routes.draw do
  #resources :breast_feedings
  #resources :babies
  resources :babies do
    resources :breast_feedings
  end
  root 'babies#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
