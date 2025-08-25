Rails.application.routes.draw do
  devise_for :users, path: 'user', controllers: {
    registrations: "publics/registrations",
    sessions: 'publics/sessions',
    passwords: 'publics/passwords'
  }
  devise_for :admins, path: 'admin', controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'publics/sessions#guest_sign_in'
  end
  
  scope module: :public do
    root to: 'homes#top'
    resources :users, only:[:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resources :comments, only:[:create, :destroy] 
    end
    resources :groups do
      resources :group_users, only:[:create]
      resources :messages, only:[:create, :destroy]
      resources :shifts, only:[:new, :create, :edit, :update, :destroy]
    end
  end

  namespace :admin do
    root to: 'homes#top'
    resources :posts ,only:[:index, :show, :destroy]
    resources :users, only:[:index, :show] do
      member do
        patch :withdraw
      end
    end
    resources :comments ,only:[:index, :destroy]
    resources :groups ,only:[:index, :show, :destroy]
  end

  
  get '/search', to: "public/searches#search"
  get 'homes/about', to: "public/homes#about", as: 'about'
  get "/user/unsubscribe" => "public/users#unsubscribe", as: 'unsubscribe_user'
  patch "/user/withdraw" => "public/users#withdraw", as: 'withdraw_user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
