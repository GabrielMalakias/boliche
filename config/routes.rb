Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :players, only: [:create]

  resources :games, only: [:create, :show] do
    member do
      post :shot
    end
  end
end
