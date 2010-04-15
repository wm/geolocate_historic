ActionController::Routing::Routes.draw do |map|
  map.connect '/historic_places/mobile', :controller => 'historic_places', :action => 'mobile'
  map.connect '/query_locations/mobile', :controller => 'query_locations', :action => 'mobile'
  map.resources :query_locations
  map.resources :historic_places
  map.a3 '/a3', :controller => 'historic_places', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => 'historic_places', :action => 'index'
end
