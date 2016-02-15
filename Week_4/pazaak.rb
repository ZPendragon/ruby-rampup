class Pazaak
	# Start game, game rules, decides winner
	attr_accessor :player, :dealer 

	def initialize(player, dealer)
		@player = player
		@dealer = dealer
	end

	def get_player_info
		puts "What's your name?"
		name_input = gets.chomp
		player.name = name_input
		puts "How much credits will you bet with tonight?"
		total_player_money = gets.chomp
		player.total_money = total_player_money.to_i
		player.side_deck.shuffle!
		player.side_deck = player.side_deck.first(4)
		dealer.side_deck.shuffle!
		dealer.side_deck = dealer.side_deck.first(4)
	end

	def start
		puts "############################################################"
		puts "Welcome to the Pazaak!! A popular game played in the underworld of Star Wars!!"
		puts
		puts "The goal of Pazaak is to have the face up cards total higher than the opponent's cards without exceeding a total of 20."
		puts "The main deck consists of cards with values in the range of 1 to 10." 
		puts "There are four cards of every value and therefore the main deck is composed of 40 cards."
		puts
		puts "Gameplay:"
		puts "1. The first player draws a card from the main deck and plays it to open up the set."
		puts "2. After drawing a card from the main deck, the player might play one of his hand cards."
		puts "3. The player holds or ends the turn."
		puts "   Holding means, the player isn't allowed to draw or play any card in the current set. The opponent however is still allowed to draw and play cards."
		puts "4. It's the other player's turn."
		puts "5. This goes on until both players hold or one of the players ends the turn with having a score of more than 20 ('Bust')."
		puts "   The player who doesn't exceed a total of 20 and has got the highest score wins the set."
		puts "   If in one set the scores of the two players are equal, the set isn't counted at all."
		puts "6. The player who wins three sets wins the match."
		puts "############################################################"
		puts 
		puts "Would you like to play a game of Pazaak? ( Yes | No ):"
		player_input = gets.chomp
		if player_input.downcase == 'yes'
			puts
			puts
			get_player_info
			play
		elsif player_input.downcase == "no"
			puts "Okay. Next time."
		else 
			puts "You're crazy. Please leave the cantina."	
		end
	end

	def play
		puts "########################################"
		if player.total_money == 0
			puts "Uh oh! You lost all your credits! Thanks for playing"
		elsif player.total_money < 0 
			puts "You owe $#{player.total_money}. Tito! Make #{player.name} pay up..."
		else
			puts "How much are you betting?"
			player_bet = gets.chomp
			player_bet = player_bet.to_i
			if player_bet > 0
				puts "Shuffling & dealing cards..."
				deck = Deck.new()
				@current_deck = deck.cards.shuffle!
				players_turn(player_bet)
			end
		end
	end

	def players_turn(player_bet)
		new_card = @current_deck.shift
		@player.hand.push(new_card)
		puts "########################################"
		puts "#{@player.name}'s Hand: #{@player.hand}" 
		puts "Total: #{@player.check_score}"
		puts "Side Deck: #{@player.side_deck}"
		puts 
		player_choice = ""
		puts "Hold // End // Card ?"
		player_choice = gets.chomp
		puts
		if player_choice.downcase == "hold"
			if @player.check_score > 20
				puts
				puts "########################################"
				puts "#{@player.name} busts!"
				puts "#{@player.name}'s Hand: #{@player.hand}" 
				puts "Total: #{@player.check_score}"
				player.total_money -= player_bet
				puts 
				puts "You bet $#{player_bet}, total money, $#{player.total_money}"
				puts
				return bust
			end
			if @dealer.end_turn == true
				return players_turn(player_bet)
			else
				dealers_turn(player_bet)
			end
		elsif player_choice.downcase == "card"
			player_card_choice = ""
			puts "Choose a card from your side deck to play 1-4"
			puts "Side Deck: #{@player.side_deck}"
			player_card_choice = gets.chomp
			player_card_choice = player_card_choice.to_i
			chosen_card = player.side_deck[player_card_choice - 1]
			@player.hand.push(player.side_deck[player_card_choice - 1])
			player.side_deck.delete_at(player_card_choice - 1)
			puts "Played #{chosen_card}"
			puts "Total: #{@player.check_score}"
			player_choice = ""
			puts "Hold // End ?"
			player_choice = gets.chomp
			if player_choice.downcase == "hold"
				if @player.check_score > 20
					puts
					puts "########################################"
					puts "#{@player.name} busts!"
					puts "#{@player.name}'s Hand: #{@player.hand}" 
					puts "Total: #{@player.check_score}"
					player.total_money -= player_bet
					puts 
					puts "You bet $#{player_bet}, total money, $#{player.total_money}"
					puts
					return bust
				end
				if @dealer.end_turn == true
					return players_turn(player_bet)
				else
					dealers_turn(player_bet)
				end
			elsif player_choice.downcase == "end"
				if @player.check_score > 20
					puts
					puts "########################################"
					puts "#{@player.name} busts!"
					puts "#{@player.name}'s Hand: #{@player.hand}" 
					puts "Total: #{@player.check_score}"
					player.total_money -= player_bet
					puts 
					puts "You bet $#{player_bet}, total money, $#{player.total_money}"
					puts
					return bust
				end
				if @dealer.end_turn == true
					win_condition(player_bet)
				else
					puts "########################################"
					@player.end_turn = true
					dealers_turn(player_bet)
				end
			end
		elsif player_choice.downcase == "end"
			if @player.check_score > 20
				puts
				puts "########################################"
				puts "#{@player.name} busts!"
				puts "#{@player.name}'s Hand: #{@player.hand}" 
				puts "Total: #{@player.check_score}"
				player.total_money -= player_bet
				puts 
				puts "You bet $#{player_bet}, total money, $#{player.total_money}"
				puts
				return bust
			end
			if @dealer.end_turn == true
				win_condition(player_bet)
			else
				puts "########################################"
				@player.end_turn = true
				dealers_turn(player_bet)
			end
		end
	end

	def dealers_turn(player_bet)
		puts "#{@player.name}'s turn is over. Dealers Turn."
		if @dealer.check_score < 17
			puts "Dealer draws..."
			@dealer.hand.push(@current_deck.shift)
			puts "Dealers Hand: #{@dealer.hand}" 
			puts "Total: #{@dealer.check_score}"
			puts "Side Deck: #{@dealer.side_deck}"
			@dealer.side_deck.each do |card|

				if (@dealer.check_score + card).between?(19,20)

					chosen_card = dealer.side_deck.index(card)
					@dealer.hand.push(card)
					dealer.side_deck.delete_at(chosen_card)
					puts "Played #{card}"
					puts "Total: #{dealer.check_score}"
					break
				end
			end


			if @dealer.check_score > 20
				puts "########################################"
				puts "Dealer busts! You win the set."
				puts "Dealers Hand: #{@dealer.hand}" 
				puts "Total: #{@dealer.check_score}"
				player.total_money += player_bet
				puts 
				puts "You bet $#{player_bet}, total money, $#{player.total_money}"
				puts
				return bust
			elsif @dealer.check_score.between?(17,20)
				@dealer.end_turn = true
				if @player.end_turn == true
					win_condition(player_bet)
				else
					players_turn(player_bet)
				end
			end

			if @player.end_turn == true
				return dealers_turn(player_bet)
			else
				players_turn(player_bet)
			end
		end
	end

	def win_condition(player_bet)

		if @player.check_score > @dealer.check_score
			puts
			puts "########################################"
			puts "#{@player.name} wins!!"
			puts "#{@player.name}'s Hand: #{@player.hand}" 
			puts "Dealers Hand: #{@dealer.hand}" 
			puts "#{@player.check_score} beats #{@dealer.check_score}."
			player.total_money += player_bet
			puts 
			puts "You bet $#{player_bet}, total money, $#{player.total_money}"
			puts "########################################"
			puts "Play Again? ( Yes | No )"
			player_input = gets.chomp
			if player_input.downcase == 'yes'
					reset_game
					puts
					puts
					play
			elsif player_input.downcase == "no"
					puts "Okay. Next time."
			else 
					puts "You're crazy. Please leave the casino."	
			end
		elsif @dealer.check_score > @player.check_score
			puts
			puts "########################################"
			puts "Dealer wins!!"
			puts "Dealers Hand: #{@dealer.hand}" 
			puts "#{@player.name}'s Hand: #{@player.hand}"
			puts "#{@dealer.check_score} beats #{@player.check_score}."
			player.total_money -= player_bet
			puts 
			puts "You bet $#{player_bet}, total money, $#{player.total_money}"
			puts "########################################"
			puts "Play Again? ( Yes | No )"
			player_input = gets.chomp
			if player_input.downcase == 'yes'
					reset_game
					puts
					puts
					play
			elsif player_input == "no"
					puts "Okay. Next time."
			else 
					puts "You're crazy. Please leave the casino."	
			end
		elsif @dealer.check_score == @player.check_score
			puts
			puts "########################################"
			puts "It's a tie!!"
			puts "#{@player.name}'s Hand: #{@player.hand}"
			puts "Dealers Hand: #{@dealer.hand}" 
			puts "#{@dealer.check_score} equals #{@player.check_score}."
			puts "You bet $#{player_bet}, total money, $#{player.total_money}"
			puts "########################################"
			puts "Play Again? ( Yes | No )"
			player_input = gets.chomp
			if player_input.downcase == 'yes'
					reset_game
					puts
					puts
					play
			elsif player_input == "no"
					puts "Okay. Next time."
			else 
					puts "You're crazy. Please leave the casino."	
			end
		end

	end

	def bust
		reset_game
		puts
		puts "Play Again? ( Yes | No )"
		player_input = gets.chomp
		if player_input.downcase == 'yes'
			puts
			puts
			play
		elsif player_input.downcase == "no"
			puts "Okay. Next time."
		else 
			puts "You're crazy. Please leave the casino."	
		end
	end

	def reset_game
		@player_score = 0
		@player.hand = []
		@dealer_score = 0
		@dealer.hand = []
		@dealer.visible_card = 0
		@player.end_turn = false
		@dealer.end_turn = false
	end

end

class Player
	# 
	attr_accessor :name, :total_money, :hand, :player_score, :side_deck, :end_turn

	def initialize
		@hand = []
		@side_deck = [1,2,3,4,5,6,-1,-2,-3,-4,-5,-6]
		@player_score = 0
		@end_turn = false
	end

	def check_score
		@player_score = 0
		@hand.each { |card| @player_score += card }
		@player_score
	end
end



class Dealer
	attr_accessor :balance, :hand, :visible_card, :dealer_score, :side_deck, :end_turn

	def initialize
		@hand = []
		@side_deck = [1,2,3,4,5,6,-1,-2,-3,-4,-5,-6]
		@dealer_score = 0
		@end_turn = false
	end

	def check_score
		@dealer_score = 0
		@hand.each { |card| @dealer_score += card }
		@dealer_score
	end

end

class Deck
	attr_accessor :cards
	def initialize
		@cards = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10]
	end
end

player = Player.new()
dealer = Dealer.new()
games = Pazaak.new(player,dealer)
games.start	