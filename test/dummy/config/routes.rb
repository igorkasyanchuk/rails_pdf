Rails.application.routes.draw do
  resources :projects
  get '/report', to: 'home#report', as: :report
  get '/download_project', to: 'home#download_project', as: :download_project
  root to: 'home#index'
end
