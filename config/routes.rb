Rails.application.routes.draw do
  get "privacy", to: "static_pages#privacy"
  get "terms", to: "static_pages#terms"
  get "howto", to: "static_pages#howto"
  devise_for :users, controllers: {
  sessions: "users/sessions",
  registrations: "users/registrations",
  passwords: "users/passwords",
  omniauth_callbacks: "users/omniauth_callbacks"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "static_pages#top"

  resources :campsites, only: [ :index, :show ] do
    resource :favorite, only: [ :create, :destroy ]
    get "favorites", to: "favorites#index"
  end

  resources :favorites, only: [ :index ]

  get "/meta/campsites/:id", to: "meta#campsite", as: :meta_campsite
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
