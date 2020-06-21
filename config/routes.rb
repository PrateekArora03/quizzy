Rails.application.routes.draw do
  root "quizzes#index"
  resources :public, only: [] do
    resources :attempts, only: [:new, :create, :edit]
  end
  resources :quizzes do
    resources :questions, except: [:index, :show]
  end
  resource :sessions, only: [:new, :create, :destroy]
end
