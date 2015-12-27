require './app/services/active_view/layout'
require 'rack/response'
require 'erb'

class ApplicationController
  extend Forwardable
  include ActiveView::Layout

  def_delegator :@app_response, :render

  attr_reader :request, :route, :params

  def initialize(request, route, app_response)
    @request = request
    @route = route
    @app_response = app_response
    @params = build_params
  end

  def build_params
    {
      'id' => id,
    }.merge!(parsed_query_string)
  end

  def parsed_query_string
    request.env['QUERY_STRING'].split('&').each_with_object({}) do |ob, hash|
      hash[ob.split('=').first] = ob.split('=').last
    end
  end

  def id
    return nil unless route['type'] == 'member'
    request.env['PATH_INFO'][1..-1].split('/')[1]
  end
end

