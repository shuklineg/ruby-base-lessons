require_relative 'interface_helpers'

module Menu
  include InterfaceHelpers

  MAIN_MENU = [
    { title: 'Станции', answer: '1', callback: :stations_menu },
    { title: 'Маршруты', answer: '2', callback: :routes_menu },
    { title: 'Поезда', answer: '3', callback: :trains_menu },
    { title: 'Выход', answer: 'exit', break: true }
  ].freeze

  TRAINS_MENU = [
    { title: 'Список', answer: '1', callback: :list_trains },
    { title: 'Добавить', answer: '2', callback: :add_train },
    { title: 'Управление поездом', answer: '3', callback: :train_edit },
    { title: 'Назад', answer: '0', break: true }
  ].freeze

  TRAIN_MENU = [
    { title: 'Назначить маршрут', answer: '1', callback: :set_route },
    { title: 'Движение вперед', answer: '2', callback: :move_forward },
    { title: 'Движение назад', answer: '3', callback: :move_backward },
    { title: 'Добавить вагон', answer: '4', callback: :hook_car },
    { title: 'Удалить вагон', answer: '5', callback: :unhook_car },
    { title: 'Список вагонов', answer: '6', callback: :cars },
    { title: 'Загрузить вагон/занять место', answer: '7', callback: :car_load },
    { title: 'Назад', answer: '0', break: true }
  ].freeze

  ROUTES_MENU = [
    { title: 'Список', answer: '1', callback: :list_routes },
    { title: 'Добавть', answer: '2', callback: :add_route },
    { title: 'Добавить станцию к маршруту', answer: '3', callback: :add_station_to_route },
    { title: 'Удалить промежуточную остановку', answer: '4', callback: :remove_station_from_route },
    { title: 'Назад', answer: '0', break: true }
  ].freeze

  STATIONS_MENU = [
    { title: 'Список', answer: '1', callback: :list_stations },
    { title: 'Поезда на станции', answer: '2', callback: :list_station_trains },
    { title: 'Добавть', answer: '3', callback: :add_station },
    { title: 'Назад', answer: '0', break: true }
  ].freeze

  def show_menu(menu_list, title, controller)
    loop do
      title_elm(title)
      menu_list.each { |elm| menu_elm(elm[:title], elm[:answer]) }
      answer = get_answer('Выберите вариант отвера').downcase

      selected = menu_list.find { |elm| elm[:answer] == answer }
      break if selected && selected[:break]

      controller.method(selected[:callback]).call if selected
    end
  end
end
