Rails.application.routes.draw do
  root "quizzes#index"
  resources :quizzes, only: [:index, :new, :show, :create, :edit, :update, :destroy]
  resource :sessions, only: [:new, :create, :destroy]
end
