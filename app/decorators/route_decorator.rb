class RouteDecorator
  attr_reader :opts, :method, :path

  def initialize(path, method, opts)
    @path = path
    @method = method
    @opts = opts
  end

  def decorate
    {
      'path' => path,
      'action' => action,
      'method' => method,
      'type' => type,
      'controller' => controller,
    }
  end

  private

  def action
    raise 'Missing parameter' unless opts[:to]
    opts[:to].split('#').last
  end

  def controller
    opts[:controller] || opts[:to].split('#').first
  end

  def type
    (opts[:on] && opts[:on].to_s) || 'collection'
  end

end
