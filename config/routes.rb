Budget::Application.routes.draw do
  root to: 'Home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match '/new_budget' => 'wallets#new', :as => :new_budget
  match '/create_budget' => 'wallets#create', :as => :create_budget, :via=> :post

  match '/new_expense' => 'expenses#new', :as => :new_expense
  match '/create_expense' => 'expenses#create', :as => :create_expense, :via => :post
end
