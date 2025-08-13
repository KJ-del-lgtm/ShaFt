Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "publics/registrations",
    sessions: 'publics/sessions',
    passwords: 'publics/passwords'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }
  
  scope module: :public do
    root to: 'homes#top'
    resources :users, only:[:index, :show, :edit, :update]
    resources :posts
  end

  namespace :admin do
    root to: 'homes#top'
  end
  
  get 'homes/about', to: "public/homes#about", as: 'about'
  get "/user/unsubscribe" => "public/users#unsubscribe", as: 'unsubscribe_user'
  patch "/user/withdraw" => "public/users#withdraw", as: 'withdraw_user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
