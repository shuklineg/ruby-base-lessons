puts 'Введите a'
a = gets.to_f
puts 'Введите b'
b = gets.to_f
puts 'Введите c'
c = gets.to_f

d = b**2 - 4.0 * a * c

if d < 0
  puts 'Корней нет'
elsif d.zero?
  x = -b / (2.0 * a)
  puts "Дискриминант равен #{d}, корень уровнения #{x}"
else
  sqrt = Math.sqrt(d)
  x1 = (-b + sqrt) / (2.0 * a)
  x2 = (-b - sqrt) / (2.0 * a)
  puts "Дискриминант равен #{d}, Корни уровнений: x1 = #{x1}, x2 = #{x2}."
end
