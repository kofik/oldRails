Depot::Application.routes.draw do
  
    get 'admin' => 'admin#index'
   
    controller :sessions do
      get 'login' => :new
      post 'login' => :create 
      delete 'logout' => :destroy
    end
  
#  scope '(:locale)' do    
    resources :users
  
    resources :store
    # root :to => 'store#index', :as => 'store', :via => [:get, :post]
  
    resources :carts do
      resources :line_items
    end
  
    resources :orders do
      resources :line_items
    end
    
    resources :orders do
      resources :payment_types
    end
  
    resources :payment_types do
      resources :orders
    end
  
    resources :products do
      resources :line_items
    end
  
    resource :products do
      resource :line_items do
        resource :orders do
          resource :payment_types  
        end
      end
    end 
  
    resources :line_items
  
    resources :carts
  
    resources :products
  
    resources :orders
  
    resources :products do
      get :who_bought
      get "products/index"
    end
  
    resources :payment_types
    
    # get 'admin', :to => "access#index"
  
    match ':controller(/:action(/:id(.:format)))', :via => [:get, :post, :delete, :patch, :put]
  
    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".
  
    # You can have the root of your site routed with "root"
    # root 'welcome#index'
  
    # Example of regular route:
    #   get 'products/:id' => 'catalog#view'
  
    # Example of named route that can be invoked with purchase_url(id: product.id)
    #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  
    # Example resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products
  
    # Example resource route with options:
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
  
    # Example resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end
  
    # Example resource route with more complex sub-resources:
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', on: :collection
    #     end
    #   end
    
    # Example resource route with concerns:
    #   concern :toggleable do
    #     post 'toggle'
    #   end
    #   resources :posts, concerns: :toggleable
    #   resources :photos, concerns: :toggleable
  
    # Example resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end
#  end
  
end
