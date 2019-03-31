class PassengerCar < Car
  attr_reader :passengers

  def initialize(capacity)
    @type = 'Пассажирский'
    @passengers = 0
    super capacity.to_i
  end

  def take_seat
    raise Overload if free_seats.zero?

    @passengers += 1
  end

  def free_seats
    @capacity - @passengers
  end

  def to_s
    "#{@type} вагон, свободно мест #{free_seats} из #{capacity} "
  end
end
