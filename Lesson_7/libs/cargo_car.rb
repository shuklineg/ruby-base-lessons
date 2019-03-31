class CargoCar < Car
  attr_reader :capacity, :cargo

  def initialize(capacity)
    @type = 'Грузовой'
    @cargo = 0
    super capacity.to_f
  end

  def take_cargo(new_cargo)
    new_cargo = new_cargo.to_f
    raise Overload if new_cargo > free_space

    @cargo += new_cargo
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
