class CargoTrain < Train
  def initialize(number)
    super number
    @type = 'Грузовой'
  end

  def hook(car)
    hook_any(car) if car.is_a? CargoCar
  end
end
