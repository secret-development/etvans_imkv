# -*- encoding : utf-8 -*-
Crm::Application.routes.draw do
  
  namespace :website do resources :advices end

  # website:
  root :to => "website/pages#index"
  match "contacts" => "website/pages#contacts"
  match "about" => "website/pages#about"
  match "subject/:id" => "website/subject#show", :as => "subweb"
  match "hot_deals" => "website/deals#index", :as => "hot_deals"
  
  # app:
  
  match "etvans" => 'results#index'
  
  scope "/etvans" do
    match "search" => 'results#index'
    
    resources :customeraccesses

    resources :paginators, :except => [:new, :create, :destroy]
    resources :worktimes

    get "reports" => "reports#index", :as => :reports
    resource :reports do
      get "activ", :on => :member, :as => :activ
      get "finance", :on => :member, :as => :finance
      get "general", :on => :member, :as => :general
    end
    get "sign_in" => "sessions#new", :as => "sign_in"
    get "sign_out" => "sessions#destroy", :as => "sign_out"

    get "sign_up => " "users/new", :as => "sign_up"
    resources :users do
      get 'add_info', :on => :member, :as => :add_info
    end
    resource :sessions
    resource :password_resets

    get "potentials/index"
    match "potentials" => "potentials#index", :as => :potentials
    resources :tasks do
      get 'admin', :on => :collection
    end
    resources :customers do
      get 'all', :on => :collection
      post 'lastcallcustomer', :on => :collection
    end

    resources :subjects do
      resources :photos, :only => [:create, :destroy]
      get 'add_properties', :on => :member, :as => :add_properties
      get 'add_photo', :on => :member, :as => :add_photo
      get 'guest', :on => :member, :as => :guest
      post 'findtypesubject', :on => :collection
      post 'load_attr', :on => :collection
      # scopes:
      get 'active', :on => :collection
      get 'inactive', :on => :collection

    end

    resources :transactions do
      get 'all', :on => :collection
      resources :documents, :only => [:create, :destroy]
      get 'add_document', :on => :member, :as => :add_document
    end
    resources :cities, :except => [:show]
    resources :social_statuses, :except => [:show]
    resources :condition_fields
    resources :value_fields, :except => [:show]
    resources :typesubjects, :except => [:show]
    resources :districts, :except => [:show]
    resources :residents, :except => [:show]
    # settings
    match "settings" => "settings#index", :as => :settings

    # for search
    resources :results

    # help:
    get "help/search" => "help#search", :as => :help_search
    get "help/customers" => "help#customers", :as => :help_customers
    get "help/subjects" => "help#subjects", :as => :help_subjects
    get "help/users" => "help#users", :as => :help_users
    get "help/tasks" => "help#tasks", :as => :help_tasks
    get "help/transactions" => "help#transactions", :as => :help_transactions
    get "help/reports" => "help#reports", :as => :help_reports
    get "help/danger" => "help#danger", :as => :help_danger
    
  end

  
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
  # match ':controller(/:action(/:id(.:format)))'
end
