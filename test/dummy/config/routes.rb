Rails.application.routes.draw do
  get '/report', to: 'home#report', as: :report
  root to: 'home#index'
end
