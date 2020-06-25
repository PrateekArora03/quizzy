Rails.application.routes.draw do
  root "quizzes#index"
  resources :public, only: [] do
    resources :attempts, only: [:new, :create, :edit, :update, :show]
  end
  resources :quizzes do
    resources :questions, except: [:index, :show]
  end
  resource :sessions, only: [:new, :create, :destroy]
  resource :reports, only: [:show]
end
