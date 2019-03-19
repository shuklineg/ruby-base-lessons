puts "Введите a"
a = gets.to_f
puts "Введите b"
b = gets.to_f
puts "Введите c"
c = gets.to_f

d = b**2 - 4*a*c

if d < 0 
  puts "Корней нет"
else
  x1 = (-b + Math.sqrt(d))/(2*a)
  x2 = (-b - Math.sqrt(d))/(2*a)
  puts "Корни уровнений: x1 = #{x1}, x2 = #{x2}"
end
