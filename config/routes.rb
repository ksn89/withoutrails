require './app/services/my_app/route'

MyApp::Routes.draw do |route|

  route.get '/projects', to: 'projects#index'
  route.get '/blocks', to: 'blocks#index'
  route.get '/blocks/:id', to: 'blocks#show', on: :member
  route.get '/blocks/:id/edit', to: 'blocks#edit', on: :member

end
