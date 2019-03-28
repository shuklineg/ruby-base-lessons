class Station
  include InstanceCounter

  NotUnique = Class.new(StandardError)
  EmptyName = Class.new(StandardError)

  attr_reader :trains, :name

  @@stations = {}

  def self.all
    @@stations.values
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations[name.downcase] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def arrival(train)
    @trains[train.number] = train
  end

  def trains_cargo
    trains.select { |train| train.is_a? CargoTrain }
  end

  def trains_passenger
    trains.select { |train| train.is_a? PassengerTrain }
  end

  def departure(train)
    @trains.delete(train.number)
  end

  def to_s
    "Станция #{@name}, всего поездов #{@trains.count}"
  end
  
  protected

  def validate!
    name = @name.downcase
    raise EmptyName if @name.empty?
    raise NotUnique if @@stations[name] && @@stations[name] != self
  end
end
