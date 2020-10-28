Rails.application.routes.draw do
  root to: "questions#index"

  devise_for :users
  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :rewards, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :questions do
    resources :answers, shallow: true do
      member do
        post :mark_as_best
      end
    end
  end
end
