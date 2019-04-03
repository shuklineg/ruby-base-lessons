class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  
  def initialize(number)
    super number
    @type = 'Грузовой'
  end

  def hook(car)
    hook_any(car) if car.is_a? CargoCar
  end
end
