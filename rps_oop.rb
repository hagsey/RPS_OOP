class Player
  attr_accessor :choice
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def show_hand
    puts "#{name} chose #{Game::HANDS[choice]}"
    sleep 1
  end
end

class Human < Player 
 
  def initialize
    puts "What is your name?"
    human_name = gets.chomp
    @name = human_name
  end

  def select_hand
    begin
      puts "Choose one: (R/P/S)"
      human_choice = gets.chomp.upcase
    end until Game::HANDS.keys.include?(human_choice)
   self.choice = human_choice
  end
end

class Computer < Player
  def select_hand
    self.choice = Game::HANDS.keys.sample 
  end
end


class Game
  HANDS = {'R' => 'Rock', 'P' => 'Paper', 'S' => 'Scissors'}        

  attr_reader :player, :computer 

  def initialize
    @player = Human.new
    @computer = Computer.new("iMac")
  end

  def display_winning_message(winning_choice)
    case winning_choice
    when 'P'
      puts "Paper covers rock!"
    when 'S'
      puts "Scissors cuts paper!"
    when 'R'
      puts "Rock smashes scissors!"
    end
  end

  def compare_hands
    result = player.choice + computer.choice
    case result
    when 'RR', 'SS', 'PP'
      puts "It's a tie."
    when 'RS', 'PR', 'SP'
      display_winning_message(player.choice)
      puts "#{player.name} won!"
    else
      display_winning_message(computer.choice)
      puts "#{player.name} lost :("
    end
  end

  def welcome_message
    sleep 1
    puts "Welcome #{player.name}, let's play Rock, Paper, Scissors!"
  end

  def play_again
    puts "Play again? (Y/N)"
    gets.chomp.upcase == 'Y'
  end

  def play
    welcome_message
    loop do
      player.select_hand
      computer.select_hand
      player.show_hand
      computer.show_hand
      compare_hands
      break unless play_again
    end
  end
end

game = Game.new.play