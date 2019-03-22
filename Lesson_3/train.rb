class Train
  attr_reader :type
  attr_reader :speed
  attr_reader :number_of_cars

  def initialize(number, type, number_of_cars)
    @number = number
    @type = type
    @number_of_cars = number_of_cars
    @speed = 0
    @route = nil
    @current_station = nil
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
    schedule = @route.schedule
    return unless schedule.size > @current_station_index + 1

    @current_station.departure(self)
    @current_station_index += 1
    @current_station = schedule[@current_station_index]
    @current_station.arrival(self)
  end

  def move_backward
    schedule = @route.schedule
    return unless @current_station_index - 1 > 0

    @current_station.departure(self)
    @current_station_index -= 1
    @current_station = schedule[@current_station_index]
    @current_station.arrival(self)
  end
end
