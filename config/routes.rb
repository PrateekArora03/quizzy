Rails.application.routes.draw do
  root "quizzes#index"
  resources :quizzes
  resource :sessions, only: [:new, :create, :destroy]
end
