Rails.application.routes.draw do
  get 'home/front'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :sites do
    resources :images
  end

  resources :session

  resources :signed_urls, only: :index

  get   '/login' => 'session#login_openid'
  get   '/show_login' => 'session#show_login'
  get   '/logout' => 'session#logout'

  get   '/sites/:id/upload' => 'sites#upload'

  put   '/images/:id/set_thumbnail' => 'images#set_thumbnail'
  get   '/images/:id/set_good' => 'images#set_good'
  get   '/images/:id/set_nok' => 'images#set_nok'
  get   '/images/:id/set_bad' => 'images#set_bad'

  get   '/images/:id' => 'images#show'
  # You can have the root of your site routed with "root"
  root  'home#front'

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
