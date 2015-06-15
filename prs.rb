# 1. all players pick either Parper, Rock or Scissors
# 2. compare: paper > rock, rock > scissors, scissors > paper, or tie if same
# 3. play again?

CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}
puts "Play Paper Rock Scissors!"

def display_winning_message(winning_choice)
  case winning_choice
  when 'p'
    puts "Paper wraps Rock!"
  when 'r'
    puts "Rock crushes Scissors!"
  when 's'
    puts "Scissors shreds Paper!"
  end
end

loop do
  # player makes a pick
  begin
    puts "Choose one: (P/R/S)"
    player_choice = gets.chomp.downcase
  end until CHOICES.keys.include?(player_choice)

  puts "You chose #{CHOICES[player_choice]}!"

  # computer makes a pick
  computer_choice = CHOICES.keys.sample
  puts "The computer chose #{CHOICES[computer_choice]}!"

  if player_choice == computer_choice
    puts "It's a tie!"

    # player wins?
  elsif (player_choice == 'p' && computer_choice == 'r') || (player_choice == 'r' && computer_choice == 's') || (player_choice == 's' && computer_choice == 'p')
    display_winning_message(player_choice)
    puts "You won!"
  else
    display_winning_message(computer_choice)
    puts "Computer won!"

  end

  puts "Do you want to play again? (Y/N)"
  break if gets.chomp.downcase != 'y'

end

puts "Thanks for playing!"