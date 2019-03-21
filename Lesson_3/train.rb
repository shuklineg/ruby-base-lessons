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
    @route.schedule.first.arrival(self)
  end

  def pos
    pos = [nil, nil, nil]
    schedule = @route.nil? ? [] : @route.schedule
    schedule.each_with_index do |station, index|
      next unless station.trains.include? self

      pos[0] = schedule[index - 1] if index > 0
      pos[1] = station
      pos[2] = schedule[index + 1] if schedule.size > index + 1
      break
    end
    pos
  end

  def move_forward
    _backward, current, forward = pos
    return if forward.nil?

    current.departure(self)
    forward.arrival(self)
  end

  def move_backward
    backward, current, _forward = pos
    return if backward.nil?

    current.departure(self)
    backward.arrival(self)
  end
end
