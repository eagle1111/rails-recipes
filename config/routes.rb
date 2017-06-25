Rails.application.routes.draw do

  devise_for :users

  resources :events do
    resources :registrations do
      member do
        get "steps/1" => "registrations#step1", :as => :step1
        patch "steps/1/update" => "registrations#step1_update", :as => :update_step1
        get "steps/2" => "registrations#step2", :as => :step2
        patch "steps/2/update" => "registrations#step2_update", :as => :update_step2
        get "steps/3" => "registrations#step3", :as => :step3
        patch "steps/3/update" => "registrations#step3_update", :as => :update_step3
      end
    end
  end

  namespace :admin do
    root "events#index"
    resources :events do
      resources :tickets, :controller => "event_tickets"
      resources :registrations, :controller => "event_registrations"
      member do
        post :reorder
      end
      collection do
        post :bulk_update
      end
    end
    resources :categories
    resources :users do
      resource :profile, :controller => "user_profiles"
    end
  end

  resource :user
  get "/faq" => "pages#faq"
  root "events#index"

end
