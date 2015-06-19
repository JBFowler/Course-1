# Welcome Player
# Give Player one card face up
# Give Dealer one card face up
# Give Player one card face up
# Give Dealer one card face down
# Ask player if he wants to hit or stay
# if player hits, give him another card, and continue to do this until he stays or busts
# Turn 2nd dealer card over.  If under 17, give dealer another card until he's over 17 or busts.
# whoever has highest number less than or equal to 21 is winner

require 'pry'

def say(msg)
  puts "=> #{msg}"
end

def first_card_suit(player)
  case player[0][0]
  when 'H'
    h = 'Hearts'
  when 'D'
    d = 'Diamonds'
  when 'S'
    s = 'Spaids'
  else
    c = 'Clubs'
  end
end

def last_card_suit(player)
  case player.last.first
  when 'H'
    h = 'Hearts'
  when 'D'
    d = 'Diamonds'
  when 'S'
    s = 'Spaids'
  when 'C'
    c = 'Clubs'
  end
end

def calculate_total(cards) 
  # [['H', '3'], ['S', 'Q'], ... ]
  arr = cards.map{|e| e[1] }

  total = 0
  arr.each do |value|
    if value == "Ace"
      total += 11
    elsif value.to_i == 0 # Jack, Queen, King
      total += 10
    else
      total += value.to_i
    end
  end

  #correct for Aces
  arr.select{|e| e == "Ace"}.count.times do
    total -= 10 if total > 21
  end

  total
end

def calculate_total(player)
  array = player.map{ |a| a[1] }
  total = 0
  array.each do |value|
    if value == 'Jack' || value == 'Queen' || value == 'King'
      total += 10
    elsif value == 'Ace'
      total += 11
    else
      total += value.to_i
    end
  end

  array.select { |a| a == "Ace" }.count.times do
    total -=10 if total > 21
  end

  total
end

# Welcome player

say "Welcome to BlackJack!"

sleep(2)

say "What is your name?"
player_name = gets.chomp

say "Welcome #{player_name}!"

sleep(2)

say "The goal of the game is to earn 300 chips."

sleep(3)

say "You will start with 100 chips.  If you beat the dealer, you win the amount of chips you bet before the deal."

sleep(4)

say "If you lose to the dealer or bust, you will lose the amount of chips you bet before the deal."

sleep(4)

say "Once you earn 300 chips you win and the game is over!  The game is also over if you lose all of your chips."

sleep(4)

say "Are you ready to play? (Y/N)"
ready = gets.chomp.upcase

if ready == "Y"
  say "Okay, Let's begin!"
else
  say "Thanks for playing!"
  exit
end

sleep(2)

chip_total = 100

begin

chips_wagered = 0
player_total = 0
dealer_total = 0

  # Create Deck

  suits = ['H', 'D', 'S', 'C']
  deck = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

  deck = suits.product(deck)
  deck.shuffle!

  player_cards = []
  dealer_cards = []

  player_cards << deck.pop
  dealer_cards << deck.pop
  player_cards << deck.pop
  dealer_cards << deck.pop

  first_player_suit = first_card_suit(player_cards)
  first_dealer_suit = first_card_suit(dealer_cards)
  last_player_suit = last_card_suit(player_cards)
  last_dealer_suit = last_card_suit(dealer_cards)

  say "Your chip total is currently #{chip_total}."

  sleep(2)

  say "How many chips would you like to wager?"
  chips_wagered = gets.chomp.to_i
  while chips_wagered > chip_total do
    say "Your wagered amount is too high, please enter an amount less or equal to your current chip count."
    chips_wagered = gets.chomp.to_i
  end

  sleep(2)

  if player_cards[0][1] == 'Ace' || player_cards[0][1] == '8'
    say "#{player_name}'s first card is an #{player_cards[0][1]} of #{first_player_suit}."
  else
    say "#{player_name}'s first card is a #{player_cards[0][1]} of #{first_player_suit}."
  end

  sleep(2)

  if dealer_cards[0][1] == 'Ace' || dealer_cards[0][1] == '8'
    say "The dealer's first card is an #{dealer_cards[0][1]} of #{first_dealer_suit}."
  else
    say "The dealer's first card is a #{dealer_cards[0][1]} of #{first_dealer_suit}."
  end

  sleep(2)

  if player_cards[1][1] == 'Ace' || player_cards[1][1] == '8'
    say "#{player_name}'s second card is an #{player_cards[1][1]} of #{last_player_suit}."
  else
    say "#{player_name}'s second card is a #{player_cards[1][1]} of #{last_player_suit}."
  end

  sleep(2)

  
  player_total = calculate_total(player_cards)
  dealer_total = calculate_total(dealer_cards)

  say "#{player_name}'s total amount is #{player_total}."

  sleep(2)

  if player_total < 21
    say "Would #{player_name} like to hit or stay?(H/S)"
    hit_again = gets.chomp.upcase
    
    while hit_again == 'H' do
      player_cards << deck.pop
      # if player_cards.last[1] == 'Jack' || player_cards.last[1] == 'Queen' || player_cards.last[1] == 'King'
      #   player_cards.last[1] = '10'
      # end
      last_player_suit = last_card_suit(player_cards)
      say "#{player_name}'s new card is a #{player_cards.last.last} of #{last_player_suit}."
      # player_total = player_total + player_cards.last.last.to_i
      player_total = calculate_total(player_cards)
      player_total
      sleep(2)
      say "#{player_name}'s new total is #{player_total}!"
      if player_total > 21
        sleep(2)
        break
      elsif player_total == 21
        break
      else
        sleep(2)
        say "Would #{player_name} like to hit or stay?(H/S)"
      end
      sleep(2)
      hit_again = gets.chomp.upcase
    end
  end 

  if player_total <= 21
    say "The dealer's second card is #{dealer_cards[1][1]}."
    sleep(2)
    say "The dealer's total is #{dealer_total}."

    sleep(2)

    while dealer_total < 17 do
      say "The dealer will hit again."
      sleep(2)
      dealer_cards << deck.pop
      # if dealer_cards.last[1] == 'Jack' || dealer_cards.last[1] == 'Queen' || dealer_cards.last[1] == 'King'
      #   dealer_cards.last[1] = '10'
      # end
      last_dealer_suit = last_card_suit(dealer_cards)
      say "The dealer got a #{dealer_cards.last.last} of #{last_dealer_suit}."
      sleep(2)
      # dealer_total = dealer_total + dealer_cards.last[1].to_i
      dealer_total = calculate_total(dealer_cards)
      dealer_total
      say "The dealer's new total is #{dealer_total}."
      sleep(2)
    end

  end

if player_total == dealer_total
  say "#{player_name} and dealer tied!"
elsif player_total == 21
  say "#{player_name} hit BlackJack and wins!"
  chip_total += chips_wagered
elsif player_total > 21
  say "#{player_name} busted!"
  chip_total -= chips_wagered
elsif dealer_total <= 21 && dealer_total > player_total
  say "Dealer wins!"
  chip_total -= chips_wagered
else
  say "#{player_name} beat the dealer!"
  chip_total += chips_wagered
end

sleep(2)

say "Your chip total is now #{chip_total}."

sleep(2)

if chip_total < 300 && chip_total > 0
  say "Would you like to keep playing?(Y/N)"
elsif chip_total >= 300
  say "Congrajulations!  #{player_name} won the game! Would you like to play again?(Y/N)"
  chip_total = 100
else
  say "#{player_name} lost :(.  Would you like to play again?(Y/N)"
  chip_total = 100
end

end while gets.chomp.upcase == 'Y'

say "Thanks for Playing #{player_name}!"




