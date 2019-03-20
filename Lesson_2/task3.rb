fibonacci = [0, 1]

fibonacci << fibonacci[-1] + fibonacci[-2] while fibonacci.last < 100

puts fibonacci
