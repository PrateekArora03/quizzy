Rails.application.routes.draw do
  root "quizzes#index"
  resources :quizzes, only: [:index, :new, :create]
  resource :sessions, only: [:new, :create, :destroy]
end
