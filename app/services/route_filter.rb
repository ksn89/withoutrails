class RouteFilter
  attr_reader :env, :route

  def initialize(env, route)
    @env = env
    @route = route
  end

  def route_exists?
    match? && (index? || show? || edit?)
  end

  private

  def match?
    split_path_info.first == route['controller']
  end

  def split_path_info
    @split_path_info ||= env['PATH_INFO'][1..-1].split('/')
  end

  def split_route_path
    @split_route_path ||= route['path'][1..-1].split('/')
  end

  def index?
    method_get? && same_lengths? && collection? && route['action'] == 'index'
  end

  def show?
    method_get? && same_lengths? && member? && route['action'] == 'show'
  end

  def edit?
    method_get? && same_lengths? && member? && split_path_info.last == 'edit' && route['action'] == 'edit'
  end

  def same_lengths?
    split_path_info.length == split_route_path.length
  end

  def method_get?
    route['method'] == env['REQUEST_METHOD'].downcase
  end

  def collection?
    route['type'] == 'collection'
  end

  def member?
    route['type'] == 'member'
  end
end
