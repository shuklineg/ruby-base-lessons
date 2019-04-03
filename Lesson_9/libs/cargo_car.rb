class CargoCar < Car
  attr_accessor_with_history :cargo

  def initialize(cargo_capacity)
    @type = 'Грузовой'
    self.cargo = 0
    super cargo_capacity.to_f
  end

  def take_cargo(new_cargo)
    new_cargo = new_cargo.to_f
    raise Overload if new_cargo > free_space

    self.cargo += new_cargo
  end

  def free_space
    @capacity - @cargo
  end

  def to_s
    "#{@type} вагон, свободный объем #{free_space} из #{capacity} "
  end

  protected

  def validate!
    raise NoCapacity unless @capacity > 0
  end
end
