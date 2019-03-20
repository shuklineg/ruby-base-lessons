cart = {}

loop do
  puts 'Введите название товара или "стоп"'
  name = gets.strip
  break if name.casecmp('стоп').zero?

  puts 'Введите цену'
  price = gets.to_f

  puts 'Введите кол-во'
  count = gets.to_i

  cart[name] = { price: price, count: count }
end

cart.each { |name, item| puts "#{item[:count]} шт. #{name}, по цене #{item[:price]} на сумму #{item[:price] * item[:count]}" }

total = cart.values.reduce(0) { |sum, item| sum + (item[:price] * item[:count]) }

puts "Всего на сумму: #{total}"
