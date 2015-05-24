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
      post :mark_purchased, on: :member
      get :undo_purchase, on: :member
      post :add_needed, on: :member
      post :subtract_needed, on: :member
    end
  end

  root to: 'stores#index'
end
