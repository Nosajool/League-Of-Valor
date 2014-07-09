LeagueOfValor::Application.routes.draw do

  root 'static_pages#home'

  # match 'link',                 to: 'controller#action',             via: 'http method'
  resources :users
  get '/change_password/:id',         to: 'users#change_password',        as: 'change_password'
  patch '/change_password_update/:id', to: 'users#change_password_update'
  get '/signup',                  to: 'users#new'
  
  resources :sessions, only: [:new, :create, :destroy]      
  get '/signin',                  to: 'sessions#new'
  match '/signout',               to: 'sessions#destroy',              via: 'delete'
        
  get '/help',                    to: 'static_pages#help'
  get '/about',                   to: 'static_pages#about'
  get '/contact',                 to: 'static_pages#contact'

  # as: 'champions' lets us use champions_path for link_to
  resources :champion_stats, controller: 'table_champions', only: :show
  # #show is now: champion_stat_path(table_champion.id)
  get '/champions',               to: 'table_champions#index',         as: 'champions'
      
  resources :champions, only: :show
  get   '/roster',                to: 'champions#edit',                as: 'roster'
  post '/change_roster',          to: 'champions#change_roster',       as: 'change_roster'
  get '/bench',                   to: 'champions#bench',               as: 'bench'
  get '/spawn_champion',          to: 'champions#spawn_page',          as: 'spawn_champion'
  post '/spawn_champion_action',  to: 'champions#spawn'
  get '/rankings_champions',      to: 'champions#rankings',            as: 'champion_ranking'

  resources :maps, only: [:index, :show]
  post '/catch',                  to: 'maps#catch'

  post '/battle',                 to: 'battle#battle',                 as: 'battle'
  get '/champion_select/:opp_id', to: 'battle#setup',                  as: 'champ_select' #champ_select_path(23)
  # Redirect /champion_select to view a profile

  resources :roles, only: [:index, :show]









  # match '/maps',             to: 'maps#index',                    via: 'get',              as: 'maps'

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
end
