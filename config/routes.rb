# -*- encoding : utf-8 -*-
V3::Application.routes.draw do

  resources :wiki_pages

  resources :wiki_contents

  resources :exchanges

  resources :feeds, :only => :index

  resources :categories
  
  resources :deliveries, :addresses, :order_items, :order_changes, :pictures, :alipay_logs, :dispatches, :dispatch_items,
            :product_tags, :product_statuses, :product_attributes, :product_attribute_defines, :products, :promotions
            
  devise_for :users, :controllers => { :registrations => "registrations" }
  get "my/info", :to => "my#index"
  #resources :areas

  get "cart/show"
  get "cart/clear"
  get "cart/delete_product"
  get "cart/update_product"
  get "cart/add_product"
  
  get "favorites/delete_product"
  get "favorites/add_product"
  get "favorites/clear"
  
  resources :favorites

  get "orders/get_coupon"
  get "orders/check_out"
  get "orders/get_carriage"
  
  resources :orders
  
  get "coupons/export"
  
  resources :coupons
  
  get "tickets/export"
  
  resources :tickets
  
  get "product_attribute_values/edit_values"
  
  resources :product_attribute_values

  match "category(/:tags(/:keywords))", :to => "products#query_result"
  get "promotion", :to => "home#promotion"
  get "info", :to => "home#info"
  #match "category/:tags", :to => "products#index"
  #match "category", :to => "products#index"

  get "home/index"

  root :to => "home#index" 

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
