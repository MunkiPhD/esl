Esl::Application.routes.draw do


  resources :circles do
    resources :members, controller: 'circle_members', only: [:index] do
      collection do
        get 'pending'
        post 'join'
        post 'leave'
      end
      member do
        post 'approve'
      end
    end
  end

  resources :exercises
  resources :workouts

  #devise_for :users
  devise_for :users, :controllers => {:registrations => "users/registrations", :passwords => "users/passwords", :sessions => "users/sessions"}

  #resources :users, :path => "/:user_id" do
  #  resources :workouts, controller: 'workouts', only: [:index, :show]
  #end

  # resources :users do
  #   resources :workouts
  # end

  get ':username/workout/:id', to: 'workouts#show', as: :user_workout
  get ':username/workouts', to: 'workouts#index', as: :user_workouts
  get ':username/workout/:id/edit', to: 'workouts#edit', as: :edit_user_workout
  delete ':username/workout/:id/delete', to: 'workouts#destroy', as: :delete_user_workout
  put ':username/workout/:id/update', to: 'workouts#update', as: :update_user_workout


  scope '/nutrition' do
		resource :nutrition_goal, path: '/goals/', only: [:edit, :update], shallow: true
    resources :favorite_foods, path: '/foods/favorites', only: [:index, :create, :destroy]
    resources :foods, except: [:index] do
      # foods/1-chicken-breast/log is the desired path
      resources :log_foods, path: '/log', shallow: true
    end
    get 'foods', to: 'foods#search', as: :search_food
    get '/', to: 'nutrition#index', as: :nutrition
  end

  scope '/api' do
    get 'nutrition/log/daily_totals', to: 'log_foods#daily_totals', as: 'log_food_daily_totals'
  end

  root to: "home#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
