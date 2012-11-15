Budget::Application.routes.draw do
  root to: 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match '/budgets' => 'wallets#index', :as => :budgets
  match '/new_budget' => 'wallets#new', :as => :new_budget
  match '/create_budget' => 'wallets#create', :as => :create_budget, :via=> :post

  resources :expenses, except: :show

  match '/new_income' => 'incomes#new', :as => :new_income
  match '/create_income' => 'incomes#create', :as => :create_income, :via => :post
  match '/all_incomes' => 'incomes#index', :as => :all_incomes
  
  match '/new_family_member' => 'users#new', :as => :new_user
  match '/create_family_member' => 'users#create', :as => :create_user, :via => :post
  match '/delete_family_member/(:id)' => 'users#destroy', :as => :destroy_user

  match '/about' => 'home#about'
  
  resources :users do
    collection do
      get :index
      post :index
    end
  end
end
