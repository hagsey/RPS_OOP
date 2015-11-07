

puts "Play Rock, Paper, Scissors!"

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

loop do
  begin
    puts "Choose one: (R/P/S)"
    player_choice = gets.chomp
  end until %(R P S).include?(player_choice)
  computer_choice = %w(R P S).sample
  puts "You picked #{player_choice} and computer picked #{computer_choice}."
  result = player_choice + computer_choice

  case result
  when 'RR', 'SS', 'PP'
    puts "It's a tie."
  when 'RS', 'PR', 'SP'
    display_winning_message(player_choice)
    puts "You won!"
  else
    display_winning_message(computer_choice)
    puts "You lost!"
  end
  puts "Play again? (Y/N)"
  play_again = gets.chomp.upcase
  break unless play_again == 'Y'
end