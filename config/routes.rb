Sitefoil::Application.routes.draw do
  get "test_site/index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/recipes/wizard' => "recipes#wizard"
  get '/recipes/selector_pick' => "recipes#selector_pick"
  get '/recipes/new_animated' => "recipes#new_animated"
  get '/recipes/after_user_create' => "recipes#after_user_create"

  resources :recipes do
    member {
      get 'duplicate'
    }
  end

  resources :channels

  resources :acts

  resources :actions

  resources :triggers

  resources :ingredients

  resources :sites do
    member {
      get 'stats'
      get 'recipes'
    }
  end

  devise_for :users

  authenticated :user do
      #root to: "recipes#index", as: "profile"
  end

  unauthenticated do
      root to: "pages#home", as: "unauthenticated"
  end  


  root "pages#home"



  get "about" => "pages#about"
  get "features" => "pages#features"
  get "ecommerce" => "pages#ecommerce"
  get "privacy" => "pages#privacy"
  get "terms" => "pages#terms"
  get "signup" => "pages#subscribe"

  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]


resources :users
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

  match "/:controller(/:action)", via: [:get,:post]
end
