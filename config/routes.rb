Rails.application.routes.draw do

  resources :users
  patch 'update_current/:id', to: 'users#update_current', as: :update_current


  resources :ideas

  resources :competitions do
    resources :ideas

  end

  get 'run/:id', to: 'competitions#run', as: :competition_runs
  get 'buy/:id', to: 'competitions#buy', as: :competition_buys
  get 'sell/:id', to: 'competitions#sell', as: :competition_sells


  root to: 'competitions#index'
  # For details on the DSL available within this file, see  http://guides.rubyonrails.org/routing.html
end
