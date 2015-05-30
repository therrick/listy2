Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  resources :stores do
    post :mark_all_purchased, on: :member
    resources :aisles do
      post :sort, on: :collection
      post :move_up, on: :member
    end
    resources :items do
      member do
        post :mark_purchased
        get :undo_purchase
        post :add_needed
        post :subtract_needed
      end
      get :menu_popup, on: :member
    end
  end

  root to: 'stores#index'
end
