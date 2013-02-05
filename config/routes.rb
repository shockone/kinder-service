Shop::Application.routes.draw do
  root :to => 'items#index'  

  resources :categories
  resources :items
  resources :orders, only: [:index, :new, :create, :destroy]
  resources :banners, except: :show

  get 'orders/archive' => 'orders#archive', as: :orders_archive
  post 'orders/complete/:id' => 'orders#complete', as: :complete_order

  post 'checkout' => 'carts#checkout', as: :checkout
  post 'carts/add' => 'carts#add', as: :add_to_cart
  delete 'carts/remove' => 'carts#remove', as: :remove_from_cart
  delete 'carts/clear' => 'carts#destroy', as: :clear_cart

  get 'new' => 'items#latest', as: :latest_items
  get 'special-offers' => 'items#special_offers', as: :special_offers

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'},
             controllers: {omniauth_callbacks: 'omniauth_callbacks'}

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
