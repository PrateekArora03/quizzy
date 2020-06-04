Rails.application.routes.draw do
  root "quizzes#index"
  get '/dashboard' => "quizzes#index" 
  get '/login' => 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
end
