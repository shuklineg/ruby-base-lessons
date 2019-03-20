vowels = %w[а у о ы и э я ю ё е]
chars = {}

('а'..'я').each_with_index do |char, index|
  chars[char] = index + 1 if vowels.include? char
end

puts chars
