class Train
  attr_reader :type, :speed, :number_of_cars, :route, :current_station

  def initialize(number, type, number_of_cars)
    @number = number
    @type = type
    @number_of_cars = number_of_cars
    @speed = 0
    @current_station_index = 0
  end

  def increase_speed(speed = 1)
    @speed += speed
  end

  def reduce_speed(braking = 1)
    @speed -= braking
    @speed = 0 if @speed < 0
  end

  def unhook_a_car
    @number_of_cars -= 1 if @speed.zero? && @number_of_cars > 0
  end

  def hook_a_car
    @number_of_cars += 1 if @speed.zero?
  end

  def route=(route)
    return unless route.class == Route

    @route = route
    @current_station_index = 0
    @current_station = @route.schedule.first
    @current_station.arrival(self)
  end

  def move_forward
    return unless @route.schedule.size > @current_station_index + 1

    move(next_station)
  end

  def move_backward
    return unless @current_station_index > 0

    move(previous_station)
  end

  def move(to_station)
    @current_station.departure(self)
    to_station.arrival(self)
    @current_station = to_station
    @current_station_index = @route.schedule.index(@current_station)
  end

  def next_station
    @route.schedule[@current_station_index + 1]
  end

  def previous_station
    @route.schedule[@current_station_index - 1]
  end
end
