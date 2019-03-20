puts "Введите ваше имя"
name = gets.strip

puts "Введите ваш рост"
height = gets.to_f

weight = height - 110

if weight > 0
  puts "#{name}, ваш идеальный вес #{weight}"
else
  puts "Ваш вес уже оптимальный"
end
