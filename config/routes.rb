Rails.application.routes.draw do
  get 'reimbursement/create'
  get 'reimbursement/index'
  get 'reimbursement/show'
  get 'reimbursement/delete'
  get 'reimbursement/update'
  post 'user/create'
  get 'user/show'
  get 'user/index'
  get 'user/delete'
  post 'user/login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
