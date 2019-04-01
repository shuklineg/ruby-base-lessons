class TrainController
  include InterfaceHelpers

  def initialize(train, routes)
    @train = train
    @routes = routes
  end

  def hook_car
    capacity = get_answer_or_empty('Введите вместительность вагона')
    @train.hook(CargoCar.new(capacity)) if @train.is_a? CargoTrain
    @train.hook(PassengerCar.new(capacity)) if @train.is_a? PassengerTrain
  rescue Car::NoCapacity
    show_error('Не указанна вместительность вагона')
    retry
  end

  def unhook_car
    return if message_if('Нет вагонов', @train.cars.empty?)

    car = select_from_list('Выберите вагон', @train.cars)
    @train.unhook(car)
  end

  def set_route
    return if message_if('Нет маршрутов', @routes.empty?)

    @train.route = select_from_list('Выберите маршрут', @routes)
  end

  def move_forward
    @train.move_forward
    puts "Текущая станция: #{@train.current_station.name}"
  rescue Train::NoRoute
    puts 'Нет маршрута'
  end

  def move_backward
    @train.move_backward
    puts "Текущая станция: #{@train.current_station.name}"
  rescue Train::NoRoute
    puts 'Нет маршрута'
  end

  def cars
    @train.each_car { |car| puts car }
  end

  def car_load
    return if message_if('Нет вагонов', @train.cars.empty?)

    car = select_from_list('Выберите вагон', @train.cars)
    take_seat(car) if car.is_a? PassengerCar
    load_cargo(car) if car.is_a? CargoCar
  end

  private

  def take_seat(car)
    return if message_if('Нет свободных мест', car.free_seats.zero?)

    car.take_seat
  rescue Car::Overload
    show_error('Недостаточно свободных мест')
    retry
  end

  def load_cargo(car)
    return if message_if('Нет свободного места', car.free_space.zero?)

    puts "Свободное место: #{car.free_space}"
    cargo = get_answer('Объем груза для загрузки в вагон')
    car.take_cargo(cargo)
  rescue Car::Overload
    show_error('Недостаточно свободного места')
    retry
  end
end
