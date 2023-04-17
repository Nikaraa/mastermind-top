class Computer
  attr_reader :code_is_guessed, :player_code_guessed
  COLORS = ["red", "orange", "yellow", "green", "blue", "violet"].freeze #knuth algorithm
  @code_is_guessed = false
  @player_code_guessed = false

  def initialize
    @code = [COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample]
    @untried = []
    COLORS.each { |a| COLORS.each { |b| COLORS.each { |c| COLORS.each { |d| @untried.push([a, b, c, d]) } } } }
  end

  def does_match?(guess)
    if @code == guess
      puts "You won the game!"
      @code_is_guessed = true
    else
      check_hints(guess, @code, true)
    end
  end

  def algorithm_cpu(player_code)
    cpu_guess = @untried[rand(@untried.length)]
    puts "#{cpu_guess} is computer guess!"
    if cpu_guess == player_code
      puts "Computer guessed the code!"
      player_code_guessed == true
    else
      check_hints(cpu_guess, player_code, true)
      puts "Press enter to the next guess"
      gets.chomp
    end
    @untried.select! { |c| check_hints(cpu_guess, player_code) == check_hints(c, player_code) }
  end

  def check_hints(guess, code, print = false)
    match_arr = code.map.with_index { |c, i| c == guess[i] }
    matches = match_arr.count(true)
    puts "#{matches} are matched!" if print == true

    check_idx = code.each_index.select { |i| match_arr[i] == false }
    guess_removed_guess = check_idx.map { |i| guess[i] }
    code_removed_guess = check_idx.map { |i| code[i] }
    match_not_in_position = code_removed_guess.map { |i| guess_removed_guess.include?(i) }
    partial_matches = match_not_in_position.count(true)
    puts "#{partial_matches} are not in position but the color is matched" if print == true
    return [matches, partial_matches]
  end
end