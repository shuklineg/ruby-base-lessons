cart = {}

loop do
  puts 'Введите название товара или "стоп"'
  name = gets.strip
  break if name.downcase == 'стоп'

  puts 'Введите цену'
  price = gets.to_f

  puts 'Введите кол-во'
  count = gets.to_i

  cart[name] = { price: price, count: count }
end

puts cart

total = 0

cart.each do |name, item|
  item_total = item[:count] * item[:price]
  puts "#{name} на сумму #{item_total}"
  total += item_total
end

puts "Всего на сумму: #{total}"
