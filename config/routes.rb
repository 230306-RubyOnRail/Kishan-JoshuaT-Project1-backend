Rails.application.routes.draw do
  post 'sessions/create'
  get 'sessions/destroy'
  post 'sessions/logged_in'
  post 'reimbursement/create'
  get 'reimbursement/index'
  get 'reimbursement/show/:id', to: 'reimbursement#show'
  get 'reimbursement/delete'
  put 'reimbursement/update/:id', to: 'reimbursement#update'
  post 'user/create'
  get 'user/show'
  get 'user/index'
  get 'user/delete'
  post 'user/login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
