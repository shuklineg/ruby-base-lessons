class PassengerCar < Car
  attr_reader :passengers

  def initialize(capacity)
    @type = 'Пассажирский'
    @passengers = 0
    super capacity.to_i
  end

  def take_seats(passengers)
    passengers = passengers.to_i
    raise Overload if passengers > free_seats

    @passengers += passengers
  end

  def free_seats
    @capacity - @passengers
  end

  def to_s
    "#{@type} вагон, свободно мест #{free_seats} из #{capacity} "
  end
end
