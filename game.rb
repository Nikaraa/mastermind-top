require_relative "player.rb"
require_relative "computer.rb"

class Game
  def initialize
    @player = Player.new
    @computer = Computer.new
  end

  def start_game
    puts "Welcome to the mastermind game"
    choose_mod()
  end

  def choose_mod
    puts "Please choose a gamemode between 'Codebreaker' or 'Codemaker'"
    input = gets.chomp.downcase
    until input.match?(/^codemaker$|^codebreaker$/)
      puts "Please choose a gamemode between 'Codebreaker' or 'Codemaker'"
      input = gets.chomp.downcase
    end
    if (input == "codebreaker")
      codebreaker_mode()
    else
      codemaker_mode()
    end
  end

  def codebreaker_mode
    puts "You are playing as a codebreaker! Your porpouse is to solve the secret code"
    puts "created by the computer, made by 4 colours."
    puts "You can choose between red, orange, yellow, green, blue, violet"
    puts "Remember to press enter everytime you write a colour"
    i = 12
    i.times do
      return if @computer.code_is_guessed
      puts "Computer has only #{i} guesses left"
      @player.add_guess
      @computer.does_match?(@player.guess)
      @player.reset_guess
      @player
      i -= 1
    end
    puts "You lost the game, try again!"
  end

  def codemaker_mode
    puts "You are playing as a codemaker! Your porpouse is to create a secret code"
    puts "made of 4 colours and the computer will try to solve it."
    puts "You can choose between red, orange, yellow, green, blue, violet"
    puts "Remember to press enter everytime you write a colour"
    code = @player.add_final_code
    i = 12
    i.times do
      return if @computer.player_code_guessed
      puts "Computer has only #{i} guesses left"
      @computer.algorithm_cpu(code)
      i -= 1
    end
    puts "You won the game!"
  end
end