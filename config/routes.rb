Rails.application.routes.draw do
  root to: "questions#index"

  devise_for :users
  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :rewards, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  concern :rateable do
    member do
      patch :rate_up
      patch :rate_down
      delete :cancel_vote
    end
  end

  resources :questions, concerns: %i[rateable] do
    resources :answers, shallow: true, concerns: %i[rateable] do
      member do
        post :mark_as_best
      end
    end
  end
end
