Rails.application.routes.draw do
  # Admin panel 
  namespace :admin do
    root "dashboard#index"
    resources :articles, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy] do
      member { post :ban }
    end
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member { post :ban }
    end
  end

  # Scope with languages
  scope "(:locale)", locale: /en|pl/ do
    resources :languages
    resources :categories
    resources :roles

    resource :session, only: [:new, :create, :destroy]

    resources :users do
      resources :ratings, only: [:create], controller: "user_ratings"
    end
    resources :user_ratings, only: [:destroy]

    resources :articles do
      resources :likes, only: [:create]

      resources :comments do
        resources :ratings, only: [:create, :destroy], controller: "comment_ratings"
      end

      collection do
        get :mine
      end

      member do
        get :export_pdf
      end
    end
    resources :likes, only: [:destroy]

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check

    # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
    # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

    root "articles#index"
  end
end