module InterfaceHelpers
  def menu_elm(title, answer)
    puts "#{answer}) - #{title}"
  end

  def get_answer(prompt)
    answer = ''
    loop do
      print "#{prompt}: "
      answer = gets.strip
      break unless answer.empty?
    end
    answer
  end

  def print_list(title, list)
    title_elm(title)
    puts list.empty? ? 'нет' : list
  end

  def message_if(message, condition)
    puts message if condition
    condition
  end

  def list_with_num(list)
    list.each_with_index do |item, index|
      menu_elm(item, index + 1)
    end
  end

  def decorated_line(line, decor)
    puts "#{decor}#{line}#{decor}"
  end

  def title_elm(title)
    decorated_line('-' * title.size, '+')
    decorated_line(title, '|')
    decorated_line('-' * title.size, '+')
  end

  def select_from_list(prompt, list)
    list_with_num(list)
    get_by_num(prompt, list)
  end

  def get_by_num(prompt, list)
    return if list.size.zero?

    index = 0
    loop do
      print "#{prompt}(1-#{list.size}): "
      index = gets.to_i
      break if (1..list.size).cover? index
    end
    list[index - 1]
  end

  def yes_no(prompt, default_yes = true)
    yes = default_yes
    print "#{prompt}(#{default_yes ? 'Y/n' : 'y/N'})"
    answer = gets.strip.downcase[0]
    yes = answer == 'y' if %w[y n].include? answer
    yes
  end
end
