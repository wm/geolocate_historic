ActionController::Routing::Routes.draw do |map|
  map.resources :query_locations

  map.resources :historic_places, :member => [:index => :get, :info => :get]
  map.a3 '/a3', :controller => 'historic_places', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => 'historic_places', :action => 'index'
end
