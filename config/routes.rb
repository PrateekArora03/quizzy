Rails.application.routes.draw do
  root "quizzes#index"
  get '/dashboard' => "quizzes#index" 
  get '/login' => 'sessions#new'
  resource :sessions, only: [:create, :destroy]
end
