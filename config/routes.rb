Budget::Application.routes.draw do
  scope "(:locale)", :locale => /en|pl/ do
    root to: 'home#index'

    devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}

    resources :wallets, except: :show
    resources :expenses, except: :show
    resources :incomes, except: [:show, :update, :edit]

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
end
