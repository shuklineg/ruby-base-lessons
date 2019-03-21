class Route
  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @stops = []
  end

  def schedule
    [@starting_station, @stops, @end_station].flatten
  end

  def add_station(station)
    @stops << station unless schedule.include? station
  end

  def remove_station(station)
    @stops.delete station
  end

  def print
    puts schedule
  end
end
