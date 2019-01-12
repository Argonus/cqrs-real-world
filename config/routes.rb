Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :articles do
    member do
      patch :publish
    end
  end
  resources :blogs do
    member do
      patch :publish
    end
  end
  resources :users do
    member do
      patch :confirm
    end
  end

  root to: 'articles#index'
end
