Rails.application.routes.draw do
  root 'customers#index'

  resources :settings

  resources :sales_men do
 	collection {get :import}
  	collection {post :do_import}
  end

  get '/customers/near_customers', to: 'customers#near_customers'

  resources :customers do
  	collection {get :import}
  	collection {post :do_import}
  end

end
