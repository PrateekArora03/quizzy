Rails.application.routes.draw do
  root "quizzes#index"
  resources :quizzes do
    resources :questions, only: [:new, :create]
  end
  resource :sessions, only: [:new, :create, :destroy]
end
