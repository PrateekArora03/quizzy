Rails.application.routes.draw do
  root "quizzes#index"
  resources :quizzes do
    resources :questions, except: [:index, :show]
  end
  resource :sessions, only: [:new, :create, :destroy]
end
