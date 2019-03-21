class Station
  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival(train)
    @trains << train unless @trains.include? train
  end

  def trains(type = nil)
    type.nil? ? @trains : @trains.select { |train| train.type == type }
  end

  def trains_cargo
    trains(:cargo)
  end

  def trains_passenger
    trains(:passanger)
  end

  def departure(train)
    @trains.delete train
  end

  def to_s
    "Станция #{@name}, всего поездов #{@trains.count}"
  end
end
