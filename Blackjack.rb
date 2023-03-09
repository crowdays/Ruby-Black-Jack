RED = "\e[31m"
GREEN = "\e[32m"
YELLOW = "\e[33m"
BLUE = "\e[34m"
Purple = "\e[35m"
T = "\e[36m"
O = "\e[37m"
C = "\e[38m"
STOP_COLOR = "\e[0m"

def play_blackjack
  puts "#{RED}Welcome to Ruby Blackjack!#{STOP_COLOR}"
  chips = 500

  while chips > 0
    puts "You have #{GREEN}#{chips}#{STOP_COLOR} chips."
    print "How much would you like to bet? "
    bet = gets.chomp.to_i
    if bet <= 0 || bet > chips
      puts "Invalid bet amount. Try again."
      next
    end

    deck = []
    suits = ["Hearts", "Diamonds", "Spades", "Clubs"]
    values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

    suits.each do |suit|
      values.each do |value|
        deck.push("#{value} of #{suit}")
      end
    end

    deck.shuffle!

    player_hand = []
    dealer_hand = []

    2.times do
      player_hand.push(deck.pop)
      dealer_hand.push(deck.pop)
    end

    player_total = calculate_total(player_hand)
    dealer_total = calculate_total(dealer_hand)

    puts "Dealer has: #{YELLOW}#{dealer_hand[0]}#{STOP_COLOR} and one face-down card"
    puts "You have: #{BLUE}#{player_hand[0]}#{STOP_COLOR} and#{Purple} #{player_hand[1]}#{STOP_COLOR} (total:#{T} #{player_total})#{STOP_COLOR}"

    while player_total < 21
      print "Would you like to #{RED}hit#{STOP_COLOR} or#{Purple} stand? #{STOP_COLOR}"
      action = gets.chomp.downcase

      if action == "hit"
        player_hand.push(deck.pop)
        player_total = calculate_total(player_hand)
        puts "You drew: #{player_hand.last} (total: #{player_total})"
      elsif action == "stand"
        break
      else
        puts "Invalid input. Please try again."
      end
    end

    if player_total > 21
      puts "#{RED}You busted!#{STOP_COLOR} #{O}Dealer wins.#{STOP_COLOR}"
      chips -= bet
      next
    end

    puts "Dealer's turn"
    puts "Dealer has: #{dealer_hand[0]} and #{dealer_hand[1]} (total: #{dealer_total})"

    while dealer_total < 17
      dealer_hand.push(deck.pop)
      dealer_total = calculate_total(dealer_hand)
      puts "Dealer drew: #{dealer_hand.last} (total: #{dealer_total})"
    end

    if dealer_total > 21
      puts "#{RED}Dealer busted!#{BLUE} You win."
      chips += bet
      next
    end

    if dealer_total > player_total
      puts "Dealer wins with a total of #{dealer_total}."
      chips -= bet
    elsif player_total > dealer_total
      puts "You win with a total of #{player_total}!"
      chips += bet
    else
      puts "#{GREEN}It's a tie!#{STOP_COLOR}"
    end
  end

  puts "#{RED}You have no more chips. Game over!#{STOP_COLOR}"
end

def calculate_total(hand)
  total = 0
  aces = 0

  hand.each do |card|
    value = card.split[0]
    if value.to_i != 0
      total += value.to_i
    elsif value == "Ace"
      total += 11
      aces += 1
    else
      total += 10
    end
  end

  while total > 21 && aces > 0
    total -= 10
    aces -= 1
  end

  total
end

play_blackjack
