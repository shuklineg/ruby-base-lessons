class PassengerTrain < Train
  def initialize(number)
    super number
    @type = 'Пассажирский'
  end

  def hook(car)
    hook_any(car) if car.is_a? PassengerCar
  end
end
