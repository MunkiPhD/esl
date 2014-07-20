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

	resource :user_preferences, only: [:show, :edit, :update]

	# these are basically referential routes
	resources :exercise_types, only: [:show], path: 'exercises/type/'
	resources :equipments, only: [:show], path: 'exercises/equipment/'
	resources :mechanic_types, only: [:show], path: 'exercises/mechanic_type/'
	resources :force_types, only: [:show], path: 'exercises/force_type/'
	resources :experience_levels, only: [:show], path: 'exercises/experience_level/'
	resources :muscles, only: [:index, :show]
	resources :exercises, only: [:index, :show]

	resources :workout_templates, path: 'workouts/templates/'
	
	get 'exercises/search', to: 'exercises#search'	
	
	resources :workouts
	resources :body_weights, except: [:show]
	resources :body_measurements

	#devise_for :users
	devise_for :users, :controllers => {:registrations => "users/registrations", :passwords => "users/passwords", :sessions => "users/sessions"}

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
end
