require_relative 'libs/modules/vendor'
require_relative 'libs/modules/instance_counter'

require_relative 'libs/train'
require_relative 'libs/passenger_train'
require_relative 'libs/cargo_train'
require_relative 'libs/car'
require_relative 'libs/passenger_car'
require_relative 'libs/cargo_car'
require_relative 'libs/station'
require_relative 'libs/route'

require_relative 'libs/ui/menu'

require_relative 'libs/controllers/train_controller'

class App
  include Menu

  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def run
    show_menu(MAIN_MENU, 'Главное меню', self)
  end

  def stations_menu
    show_menu(STATIONS_MENU, 'Меню станций', self)
  end

  def routes_menu
    show_menu(ROUTES_MENU, 'Меню маршрутов', self)
  end

  def trains_menu
    show_menu(TRAINS_MENU, 'Меню Поездов', self)
  end

  def list_stations
    print_list('Список станций', @stations)
  end

  def list_station_trains
    return if message_if('Нет станций', @stations.empty?)

    station = select_from_list('Введите номер станции', @stations)
    station.each_train { |train| puts train }
  end

  def add_station
    station_name = get_answer_or_empty('Введите название станции')
    station = Station.new(station_name)
    @stations << station
  rescue Station::EmptyName
    show_error('Название не должно быть пустым')
    retry
  rescue Station::NotUnique
    show_error('Станция должна иметь уникальное название')
    retry
  end

  def list_routes
    print_list('Список маршрутов', @routes)
  end

  def add_route
    return if message_if('Станций слишком мало', @stations.size < 2)

    starting_station = select_from_list('Введите номер станции начала маршрута', @stations)
    end_station = select_from_list('Введите номер станции конца маршрута', @stations)
    route = Route.new(starting_station, end_station)
    @routes << route
  rescue Route::CircleRoute
    show_error('Станции отправления и назначения должны различаться')
    retry
  end

  def add_station_to_route
    route = select_from_list('Введите номер маршрута для редактирования', @routes)
    stations = @stations - route.schedule
    return if message_if('Нет доступных станций', stations.empty?)

    station = select_from_list('Введите номер станции', stations)
    route.add_station(station)
  end

  def remove_station_from_route
    route = select_from_list('Введите номер маршрута для редактирования', @routes)
    stations = route.stops
    return if message_if('В маршруте нет станций', stations.empty?)

    station = select_from_list('Введите номер станции', stations)
    return unless yes_no("Удалить станцию #{station.name}?", false)

    station.trains.each { |train| train.move_forward if train.route == route }
    route.remove_station(station)
  end

  def list_trains
    print_list('Список поездов', @trains)
  end

  def add_train
    train_types = %w[Пассажирский Грузовой]
    train_type =  select_from_list('Выберите тип поезда', train_types)
    begin
      train_number = get_answer_or_empty('Введите номер поезда')
      case train_type
      when train_types[0]
        train = PassengerTrain.new(train_number)
      when train_types[1]
        train = CargoTrain.new(train_number)
      end
      @trains << train
    rescue Train::EmptyNumber
      show_error('Номер не может быть пустым')
      retry
    rescue Train::WrongFormat
      show_error('Не верный формат номера')
      retry
    rescue Train::NotUnique
      show_error('Номер должен быть уникальным')
      retry
    end
  end

  def train_edit
    return if message_if('Список поездов пуст', @trains.empty?)

    train = select_from_list('Выберите поезд', @trains)
    train_controller = TrainController.new(train, @routes)
    show_menu(TRAIN_MENU, "Редактирование поезда #{train.number}", train_controller)
  end
end

App.new.run
