class Score
  attr_accessor :score

  def initialize
    @score = 0
  end

  def show_score
    puts "#{name} score: #{@score}"
  end

  def add_point
    @score += 1
  end
end


class Player < Score
  attr_accessor :name, :choice

  def initialize
    set_name
  end

  def show_hand
    puts "#{name} went with #{Game::CHOICES[choice]}."
  end
end

class Human < Player
  def set_name
    human_name = ""
    begin
      puts "What is your name?"
      human_name = gets.chomp
    end until human_name.length > 0
    self.name = human_name
  end

  def select_hand
    human_choice = nil
    begin
    puts "Choose either rock (R), paper (P), or scissors (S)."
    human_choice = gets.chomp.upcase
    end until Game::CHOICES.keys.include?(human_choice)
    self.choice = human_choice  
  end 
end

class Computer < Player
  def set_name
    self.name = ["iMac", "Compy", "R2D2"].sample
  end

  def select_hand
    self.choice = Game::CHOICES.keys.sample
  end
end

class Game
  attr_accessor :human, :computer

    CHOICES = { 'R' => 'rock', 
            'P' => 'paper',
            'S' => 'scissors' }

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def welcome_message
    puts "Hello, #{human.name}...welcome to rock, paper, scissors!"
  end

  def compare_choices
    result = human.choice + computer.choice
    case result
    when 'RR', 'SS', 'PP'
      puts "It's a tie."
    when 'RS', 'PR', 'SP'
      puts "#{human.name} won!"
      human.add_point
    else
      puts "#{computer.name} won :("
      computer.add_point
    end
  end

  def exit_message
    puts "Thanks for playing, #{human.name}!"
  end

  def play_again
    puts "Play again? (Y/N)"
    gets.chomp.upcase == 'Y' 
  end

  def show_scoreboard
    human.show_score
    computer.show_score
  end

  def play
    welcome_message
    loop do
      system 'Clear'
      human.select_hand
      computer.select_hand
      human.show_hand
      computer.show_hand
      compare_choices
      show_scoreboard
      break unless play_again
    end
    exit_message
  end
end

game = Game.new.play 

