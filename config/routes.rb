Distlist::Application.routes.draw do
  devise_for :users, :path_prefix => '/:locale/auth'

  scope "/:locale", :locale => /en|it|fr/ do
    resources :campaigns do
      resources :addresses do
        get :import, :on => :collection
        post :csv, :on => :collection
        get :export, :on => :collection
      end
      resources :emails do
        resources :attachments, :only => [:show, :create, :destroy]
        put :getlog, :on => :member
        put :mail_me, :on => :member
      end
    end
  
    resources :users, :only => [:index, :create, :destroy, :new, :show] do
      put :endis, :on => :member
      put :swadmin, :on => :member 
    end

    get "/home" => "home#index" 
    get "/helpdesk" => "home#helpdesk", :as => :helpdesk
    get "/admin" => "home#admin", :as => :admin
    get "/attachment/:id/:file_file_name" => "attachments#public", :as => :apublic
  end

  get "/:locale" => "home#index"

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
  root :to => 'home#index', :locale => :en

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
