Budget::Application.routes.draw do
  scope "(:locale)", locale: /en|pl/ do
    root to: 'home#index'

    devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

    resources :wallets, except: [:show, :destroy] do
      get :confirm_destroy
      get :destroy
    end

    resources :expenses, except: :show do
      get :mark_as_done
    end

    resources :incomes, except: :show

    match '/new_family_member' => 'users#new', as: :new_user
    match '/create_family_member' => 'users#create', as: :create_user, via: :post
    match '/delete_family_member/(:id)' => 'users#destroy', as: :destroy_user

    match '/edit' => 'users#edit_profile', as: :edit_profile
    match '/about' => 'home#about'
    match '/balance' => 'balance#index', as: :actual_balance

    resources :users do
      collection do
        get :index
        post :index
      end
    end
    #needed for error pages with locale in URL
    match '*a', :to => 'errors#routing'
  end

  #needed to suppress routing error while testing 'errors#routing'
  match '/404' => 'errors#routing'
  match '*a', :to => 'errors#routing'
end
