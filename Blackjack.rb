

def play_blackjack
  puts "Welcome to Ruby Blackjack!"
  chips = 500

  while chips > 0
    puts "You have #{chips} chips."
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

    puts "Dealer has: #{dealer_hand[0]} and one face-down card"
    puts "You have: #{player_hand[0]} and #{player_hand[1]} (total: #{player_total})"

    while player_total < 21
      print "Would you like to hit or stand? "
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
      puts "You busted! Dealer wins."
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
      puts "Dealer busted! You win."
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
      puts "It's a tie!"
    end
  end

  puts "You have no more chips. Game over!"
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
