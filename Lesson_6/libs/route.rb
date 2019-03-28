class Route
  include InstanceCounter
  
  CircleRoute = Class.new(StandardError)

  attr_reader :stops

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @stops = []
    validate!
    register_instance
  end

  def validate!
    raise CircleRoute if @starting_station == @end_station
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def schedule
    [@starting_station, @stops, @end_station].flatten
  end

  def add_station(station)
    @stops << station unless schedule.include? station
  end

  def remove_station(station)
    return unless @stops.include? station

    station.trains.each { |train| train.move_forward if train.route == self }
    @stops.delete station
  end

  def to_s
    "#{@starting_station.name} - #{@end_station.name}, всего #{schedule.size} станций"
  end
end
