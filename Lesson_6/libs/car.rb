require_relative 'modules/vendor'

class Car
  include Vendor

  def to_s
    "#{@type} вагон"
  end
end
