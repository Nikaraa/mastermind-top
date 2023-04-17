class Player
  attr_reader :guess, :final_code

  def initialize
    @guess = []
    @final_code = []
  end

  def add_guess
    4.times do
      input = gets.chomp.downcase
      @guess.push(input)
    end
    puts "#{@guess} is your choice"
  end

  def reset_guess
    @guess = []
  end

  def add_final_code
    4.times do
      input = gets.chomp.downcase
      @final_code.push(input)
    end
    puts "#{@final_code} is your secret code"
    @final_code
  end
end