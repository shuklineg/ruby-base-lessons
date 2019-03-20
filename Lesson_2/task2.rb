array = (10..100).select { |num| (num % 5).zero? }

puts array
