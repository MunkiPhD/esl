Esl::Application.routes.draw do

#  get "foods/show"
#  get "foods/new"
#  get "foods/edit"
# get "foods/destroy"

  resources :nutrition do
    resources :foods, controller: "foods", except: [:index]
  end

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

   get 'nutrition/foods/:id', to: 'foods#show', as: :food
   get 'nutrition/foods/:id/edit', to: 'foods#edit', as: :edit_food
   get 'nutrition/foods/new', to: 'foods#new', as: :new_food
   put 'nutrition/foods/:id/update', to: 'foods#update', as: :update_food
   delete 'nutrition/foods/:id/delete', to: 'foods#destroy', as: :delete_food

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
