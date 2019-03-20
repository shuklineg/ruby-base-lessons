fibonacci = [0, 1]

loop do
  new_val = fibonacci[-1] + fibonacci[-2]
  break if new_val > 100

  fibonacci << new_val
end

puts fibonacci
