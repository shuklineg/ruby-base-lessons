class Station
  include Accessors
  include Validation
  include InstanceCounter

  attr_reader :trains
  validate :name, :presence
  strong_attr_accessor :name, String

  @@stations = {}

  def self.all
    @@stations.values
  end

  def initialize(name)
    @name = name
    @trains = {}
    validate!
    @@stations[name.downcase] = self
    register_instance
  end

  def each_train
    @trains.each { |train| yield train }
  end

  def arrival(train)
    @trains[train.number] = train
  end

  def trains_cargo
    trains.values { |train| train.is_a? CargoTrain }
  end

  def trains_passenger
    trains.values { |train| train.is_a? PassengerTrain }
  end

  def departure(train)
    @trains.delete(train.number)
  end

  def to_s
    "Станция #{@name}, всего поездов #{@trains.count}"
  end
end
