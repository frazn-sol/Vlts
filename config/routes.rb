VLTS::Application.routes.draw do

  resources :messages 


  resources :vehicles do

    member do
      get :track_view 
      delete :track_delete
    end

    collection do
      get :track
      post :track_create
      get :autocomplete
      get :search_vehicle
      post :create_vehicles
      post :parking_time
      get :search
    end
  end

  resources :floors

  resources :reports do
    collection do
      get :admin
      get :support
      get :supervisor
      get :customer
    end
  end

  resources :locations

  resources :organization_contacts

  resources :organizations

  resources :customer_contacts

  resources :customers

  devise_for :users do 
    get "/sign_out"  => "devise/sessions#destroy", :as => :destroy_user_session
  end


  resources :users do
    member do
      get :password
      put :change 
      put :reset1
    end

    collection do
      get :forgot
      put :email
      get :reset
      get :support
      get :supervisor
      get :user
      get :error
      get :change1
      put :change_create
      post :config_create
    end
  end

  match ':controller(/:action(/:id(.:format)))'

  resources :floors do 
     collection do
      get :management
    end
  end


  resources :home do
    collection do
      get :vlts
      get :about
    end
  end

  root :to => "home#vlts"


  resources :customers do
    collection do
      get :management
    end
  end
  # devise_for :users do
  #   get "/sign_out"  => "devise/sessions#destroy", :as => :destroy_user_session
  # end
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
