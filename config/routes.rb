Rails.application.routes.draw do
  post 'sessions/create'
  # delete 'sessions/destroy' # havent done this one yet but it's not required
  # post 'sessions/logged_in'
  post 'reimbursement/create'
  get 'reimbursement/index'
  get 'reimbursement/show/:id', to: 'reimbursement#show'
  delete 'reimbursement/delete/:id', to: 'reimbursement#delete'
  put 'reimbursement/update/:id', to: 'reimbursement#update'
  post 'user/create'
  get 'user/show'
  get 'user/index'
  get 'user/delete'
  # post 'user/login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
