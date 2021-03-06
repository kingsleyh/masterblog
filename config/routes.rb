Masterthought::Application.routes.draw do
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

  resources :articles
  match '/feed' => 'feeds#articles',
        :as => :feed,
        :defaults => {:format => 'atom'}

  match "/search" => "master#search", :as => :search

  match "/section/:id" => "master#section", :as => :section
  match "/section/:id/article/:article" => "master#section", :as => :section_article

  match "/signout" => "services#signout"

  match '/auth/:service/callback' => 'services#create'
  match '/auth/failure' => 'services#failure'

  match "/admin" => "admin#index", :as => :admin_index
  match "/login" => "admin#login", :as => :admin_signin

  match "/comments/create" => "comments#create", :as => :create_comment

  namespace :admin do
    match "/articles/new" => "articles#new", :as => :new_article
    match "/articles/create" => "articles#create", :as => :create_article
    match "/articles/edit/:id" => "articles#edit", :as => :edit_article
    match "/articles/update/:id" => "articles#update", :as => :update_article
    match "/articles/delete/:id" => "articles#delete", :as => :delete_article

    match "/uploads/new" => "uploads#new", :as => :new_upload
    match "/uploads/create" => "uploads#create", :as => :create_upload
    match "/uploads/delete/:id" => "uploads#delete", :as => :delete_upload
    match "/uploads/edit/:id" => "uploads#edit", :as => :edit_upload
    match "/uploads/update/:id" => "uploads#update", :as => :update_upload

    match "/sections/new" => "sections#new", :as => :new_section
    match "/sections/create" => "sections#create", :as => :create_section
    match "/sections/edit/:id" => "sections#edit", :as => :edit_section
    match "/sections/update/:id" => "sections#update", :as => :update_section
    match "/sections/delete/:id" => "sections#delete", :as => :delete_section

    match "/snippets/new" => "snippets#new", :as => :new_snippet
    match "/snippets/create" => "snippets#create", :as => :create_snippet
    match "/snippets/edit/:id" => "snippets#edit", :as => :edit_snippet
    match "/snippets/update/:id" => "snippets#update", :as => :update_snippet
    match "/snippets/delete/:id" => "snippets#delete", :as => :delete_snippet

    match "/comments/edit/:id" => "comments#edit", :as => :edit_comment
    match "/comments/update/:id" => "comments#update", :as => :update_comment
    match "/comments/delete/:id" => "comments#delete", :as => :delete_comment

    match "/users/show" => "users#show", :as => :show_users
    match "/users/edit/:id" => "users#edit", :as => :edit_user
    match "/users/update/:id" => "users#update", :as => :update_user
    match "/users/delete/:id" => "users#delete", :as => :delete_user

    match "/settings/new" => "settings#new", :as => :new_setting
    match "/settings/create" => "settings#create", :as => :create_setting
    match "/settings/update_key/:id" => "settings#update_key", :as => :update_key_setting
    match "/settings/update_value/:id" => "settings#update_value", :as => :update_value_setting
    match "/settings/delete/:id" => "settings#delete", :as => :delete_setting

    resources :Jqueryfiletree
      match "/extend/content" => "extend#content", :as => :show_tree
      match "/extend/new" => "extend#new", :as => :new_extend

    match "/extend/create" => "extend#create", :as => :create_extend
    match "/extend/update" => "extend#update", :as => :update_extend
    match "/extend/edit/filename/:filename/filepath/:filepath" => "extend#edit", :as => :edit_extend
    match "/extend/delete/filename/:filename/filepath/:filepath" => "extend#delete", :as => :delete_extend

  end

  resources :services, :only => [:index, :create, :destroy] do
    collection do
      get 'signout'
      get 'signup'
      post 'newaccount'
      get 'failure'
    end
  end

  # used for the demo application only
  resources :users, :only => [:index] do
    collection do
      get 'test'
    end
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'master#section'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
