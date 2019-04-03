class Route
  include Accessors
  include Validation
  include InstanceCounter

  validate :starting_station, :type, Station
  validate :end_station, :type, Station

  attr_accessor_with_history :stops

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @stops = []
    validate!
    register_instance
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
    "#{@starting_station.name} - " \
    "#{@end_station.name}, всего #{schedule.size} станций"
  end
end
