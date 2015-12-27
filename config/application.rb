require 'rack'
require 'rack/request'
require 'rack/response'
require './app/services/my_app/route'
require './app/services/my_app/response'
require './app/services/route_filter'
require './app/controllers/blocks_controller'
require './app/controllers/projects_controller'
require 'pry'
class App
  def call(env)
    MyApp::Routes.instance.routes.each do |route|
      return Rack::Response.new if favicon?(env)
      return response(env, route) if route_exists?(env, route)
    end
    raise_no_route_matches(env)
  end

  private

  def response(env, route)
    MyApp::Response.new(env, route).result
  end

  def route_exists?(env, route)
    RouteFilter.new(env, route).route_exists?
  end

  def favicon?(env)
    env['PATH_INFO'] == '/favicon.ico'
  end

  def raise_no_route_matches(env)
    raise "No route matches [#{env['REQUEST_METHOD']}] #{env['REQUEST_URI']}"
  end
end
