puts 'Введите чило'
day = gets.to_i

puts 'Введите месяц'
month = gets.to_i

puts 'Введите год'
year = gets.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

months[1] = 29 if ((year % 4).zero? && year % 100 != 0) || (year % 400).zero?

past_days = day

(1...month).each { |num| past_days += months[num - 1] }

puts "Сейчас #{past_days} день"
