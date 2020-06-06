Rails.application.routes.draw do
  root "quizzes#index"
  resources :quizzes, only: [:index]
  resource :sessions, only: [:new, :create, :destroy]
end
