require 'rack'
require 'erb'

module MyApp
  class Response
    attr_reader :env, :route

    def initialize(env, route)
      @env = env
      @route = route
    end

    def result
      controller.send(route['action'])
      build_instances
      res = Rack::Response.new
      res.write erb(layout_html) { erb yield_html }
      res.finish
    end

    def controller
      @controller ||= controller_klass.new(Rack::Request.new(env), route, self)
    end

    def build_instances
      controller.instance_variables.each do |instance|
        instance_variable_set(instance.to_s, controller.instance_variable_get(instance))
      end
    end

    def controller_klass
      @controller_klass ||= Object.const_get("#{route['controller'].capitalize}Controller")
    end

    def render(opts)
      erb read_file opts[:partial]
    end

    def erb(html)
      ERB.new(html).result(binding)
    end

    def layout_html
      read_file "./app/views/layouts/#{controller.send('layout')}.html.erb"
    end

    def yield_html
      read_file "./app/views/#{route['controller']}/#{route['action']}.html.erb"
    end
    
    def read_file(path)
      File.open(path, 'r').read
    end
  end
end
