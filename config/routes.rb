Rails.application.routes.draw do
  get '/products' => 'products#index'
  get '/products/new' => 'products#new'
  post '/products'  => 'products#create'
  get '/products/:id' => 'products#show'
  get '/products/:id/edit' => 'products#edit'
  patch '/products/:id'  => 'products#update'
  get '/forms'    => 'products#new_form'
  post '/forms'   => 'products#add_to_database'
end
