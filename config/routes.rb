# encoding: utf-8
Rails.application.routes.draw do
  root to: 'line#liste_lines'


  if Rails.env.development?
    # mount Localtower::Engine, at: 'localtower'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

     # get '/home' => 'pages#home' , as: :home 

  # Example of regular route:
    get '/signup' => 'user#signup' , as: :signup 
    post '/signup' => 'user#create_user' , as: :create_user
    get '/users/edit' => 'user#edit_user', as: :edit_user 
    post '/users/update' => 'user#update_user', as: :update_user 

    get '/login' => 'user#login', as: :login 
    post '/login' => 'user#new_session' , as: :new_session 

    get '/profile' => 'user#profile', as: :profile 

    get '/cars' => 'car#list_cars', as: :list_cars 
    get '/cars/new' => 'car#new_car', as: :new_car 
    post '/cars/new' => 'car#create_car', as: :create_car 
    get '/cars/:id/remove' => 'car#remove_car', as: :remove_car 
    get '/cars/:id/edit' => 'car#edit_car', as: :edit_car 
    post '/cars/:id/update' => 'car#update_car', as: :update_car 
    
    
    get '/lines' => 'line#liste_lines', as: :liste_lines 
    get '/lines/new' => 'line#new_line', as: :new_line 
    post '/lines/new' => 'line#create_line', as: :create_line 
    get '/lines/:id/remove' => 'line#remove_line', as: :remove_line 
    get '/lines/:id/edit' => 'line#edit_line', as: :edit_line 
    post '/lines/:id/update' => 'line#update_line', as: :update_line 

    get '/logout' => 'user#logout', as: :logout 


   
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
end
