Rails.application.routes.draw do

  resources :meals
  get 'welcome' => 'welcome#index'
  get 'welcome/about' => 'welcome#about', as: :about

  post 'welcome/login' => 'user#login', as: :login
  post 'welcome/signup' => 'user#signup', as: :signup
  get 'welcome/logout' => 'user#logout', as: :user_logout
  get 'user' => 'user#show', as: :user
  get 'matches' => 'messages#matches', as: :matches

  get 'search' => 'search#index', as: :search
  get 'search/results' => 'search#results'
  post 'search/candidates' => 'search#searchForNearbyBusinesses'
  post 'search/sendMessage' => 'search#sendMessage'
  post 'search/accept' => 'search#accept'
  post 'search/reject' => 'search#reject'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get 'messages' => 'messages#index'
  get 'profile' => 'profile#index'
  get 'profile/edit' => 'profile#edit'
  post 'profile/edit' => 'profile#submit', as: :profile_submit
  resources :messages
  root 'welcome#index'

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
end
