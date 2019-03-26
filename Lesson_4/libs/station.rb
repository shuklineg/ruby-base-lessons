class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrival(train)
    @trains << train unless @trains.include? train
  end

  def trains_cargo
    trains.select { |train| train.class == CargoTrain }
  end

  def trains_passenger
    trains.select { |train| train.class == PassengerTrain }
  end

  def departure(train)
    @trains.delete train
  end

  def to_s
    "Станция #{@name}, всего поездов #{@trains.count}"
  end
end
