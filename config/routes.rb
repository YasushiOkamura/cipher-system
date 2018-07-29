Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#index'

  resources :students, only: [:new, :create]

  namespace :admin do
    resources :students
  end

  namespace :company do
    resources :students, only: [:index] do
      collection do
        get :result
      end
    end
  end
end
