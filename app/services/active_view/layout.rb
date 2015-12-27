module ActiveView
  module Layout
    def layout
      return 'application' unless defined?(self.class::LAYOUT)
      self.class::LAYOUT
    end
  end
end
