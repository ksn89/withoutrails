require 'singleton'
require './app/decorators/route_decorator'

module MyApp
  class Routes
    include Singleton

    attr_accessor :routes

    def initialize
      @routes ||= []
    end

    def self.draw(&block)
      block.call(instance) if block_given?
    end

    def get(path, opts = {})
      routes << RouteDecorator.new(path, 'get', opts).decorate
    end
  end
end
