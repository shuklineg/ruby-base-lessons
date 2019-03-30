require_relative 'modules/vendor'

class Car
  include Vendor

  attr_reader :capacity

  Overload = Class.new(StandardError)
  NoCapacity = Class.new(StandardError)

  def initialize(capacity)
    @capacity = capacity
    validate!
  end

  protected

  def validate!
    raise NoCapacity unless @capacity > 0
  end
end
