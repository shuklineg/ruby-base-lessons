puts 'Введите первую сторону треугольника'
a = gets.to_f
puts 'Введите вторую сторону треугольника'
b = gets.to_f
puts 'Введите третью сторону треугольника'
c = gets.to_f

if a > b && a > c
  h = a
  c1 = b
  c2 = c
elsif b > c && b > a
  h = b
  c1 = a
  c2 = c
else
  h = c
  c1 = a
  c2 = b
end

if h**2 == c1**2 + c2**2
  puts 'Треугольник прямоугольный'
  puts 'Треугольник равнобедренный' if c1 == c2
elsif h == c1 && h == c2 && c1 == c2
  puts 'Треугольнки равносторонний'
end
