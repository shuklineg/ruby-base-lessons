class Train
  include Accessors
  include Validation
  include Vendor
  include InstanceCounter

  NoRoute = Class.new(StandardError)

  NUMBER_FORMAT = /^[a-zа-я0-9]{3}\-?[a-zа-я0-9]{2}$/i.freeze

  attr_reader :speed, :cars, :route, :current_station, :type, :number

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number.upcase
    @speed = 0
    @current_station_index = 0
    @cars = []
    validate!
    @@trains[@number] = self
    register_instance
  end

  def each_car
    @cars.each { |car| yield car }
  end

  def increase_speed(speed = 1)
    @speed += speed
  end

  def reduce_speed(braking = 1)
    @speed -= braking
    @speed = 0 if @speed < 0
  end

  def route=(route)
    @current_station.departure(self) if @current_station
    @route = route
    @current_station_index = 0
    @current_station = @route.schedule.first
    @current_station.arrival(self)
  end

  def move_forward
    raise NoRoute if @route.nil?
    return unless @route.schedule.size > @current_station_index + 1

    move(next_station)
  end

  def move_backward
    raise NoRoute if @route.nil?
    return unless @current_station_index > 0

    move(previous_station)
  end

  def unhook(car)
    @cars.delete(car)
  end

  def to_s
    str = "#{@type} поезд, №#{@number}"
    str << (@cars.size.zero? ? '' : " , вагонов: #{@cars.size}")
    str << (@route.nil? ? '' : " , на маршруте \"#{@route}\"")
  end

  protected

  def hook_any(car)
    @cars << car
  end

  private

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
