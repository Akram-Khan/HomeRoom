Homeroom::Application.routes.draw do

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :sessions => "sessions", :passwords => "passwords", :registrations => "registrations"} do
    get "signup", :to => "registrations#new"
    get "login", :to => "sessions#new"
    post "login", :to => "sessions#new"
    get "logout", :to => "devise/sessions#destroy"
  end

  match "/dashboard", :to => "users#dashboard"
  match "/join_by_invitation_code", :to => "courses#join_by_invitation_code"
  match "/join_as_student", :to => "courses#join_as_student"
  match "/join_as_teacher", :to => "courses#join_as_teacher"
  match "/decline_student_invitation", :to => "invite_students#decline_student_invitation"
  match "/decline_teacher_invitation", :to => "invite_teachers#decline_teacher_invitation"

  resources :courses do
    resources :invite_teachers
    resources :invite_students
    member do
      get :students
      get :teachers
    end
    resources :notes do
      resources :comments
      resources :likes
    end
    resources :links do
      resources :comments
      resources :likes
    end
    resources :videos do
      resources :comments
      resources :likes
    end
    resources :attachments do
      resources :comments
      resources :likes
    end
  end

  resources :users
  
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
   root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
