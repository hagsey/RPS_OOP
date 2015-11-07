class Player
  attr_accessor :choice
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{name} chose #{Game::HANDS.fetch(choice)}"
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
      c = gets.chomp.upcase
    end until Game::HANDS.keys.include?(c)
   self.choice = c
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

  def play
    sleep 1
    puts "Welcome #{player.name}, let's play Rock, Paper, Scissors!"
    loop do
      player.select_hand
      computer.select_hand
      puts player
      sleep 1
      puts computer
      sleep 1
      compare_hands
      sleep 1
      puts "Play again? (Y/N)"
      play_again = gets.chomp.upcase
      break unless play_again == 'Y'
    end
  end
end

game = Game.new.play