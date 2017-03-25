Rails.application.routes.draw do

  namespace :api do
    devise_for :sales_men, controllers: {
      sessions: "api/sales_men/sessions"
    }
    get '/sales_men/near_customers', to: 'sales_men/actions#near_customers'
  end

  devise_for :users

  root 'customers#index'

  resources :settings

  resources :sales_men, :except => :show do
    collection {get :import}
    collection {post :do_import}
  end

  resources :customers do
  	collection {get :import}
  	collection {post :do_import}
  end

end
