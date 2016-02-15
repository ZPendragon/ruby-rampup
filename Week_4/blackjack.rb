class Blackjack
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
		puts "How much money will you bet with tonight?"
		total_player_money = gets.chomp
		player.total_money = total_player_money.to_i
	end

	def start
		puts "############################################################"
		puts
		puts "Welcome to the Blackjack Casino!! All we play is Blackjack!"
		puts
		puts "Would you like to play a game of Blackjack? ( Yes | No ):"
		player_input = gets.chomp
		if player_input.downcase == 'yes'
			puts
			puts
			get_player_info
			play
		elsif player_input.downcase == "no"
			puts "Okay. Next time."
		else 
			puts "You're crazy. Please leave the casino."	
		end
	end

	def play
		puts "########################################"
		if player.total_money == 0
			puts "Uh oh! You lost all your money! Thanks for playing"
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
				@player.hand = @current_deck.shift(2)
				@dealer.hand = @current_deck.shift(2)
				@dealer.visible_card = @dealer.hand[0]
				puts
				puts "####################"
				puts "#{@player.name}'s Hand: #{@player.hand}" 
				puts "Total: #{@player.check_score}"
				puts "Dealer reveals: #{@dealer.visible_card}"
				puts 
				player_choice = ""
				until player_choice.downcase == "stay"
					puts "Hit or Stay?"
					player_choice = gets.chomp
					
					if player_choice.downcase == "hit"
						new_card = @current_deck.shift
						@player.hand.push(new_card)
						puts
						if @player.check_score > 21
							puts
							puts "####################"
							puts "#{@player.name} busts!"
							puts "#{@player.name}'s Hand: #{@player.hand}" 
							puts "Total: #{@player.check_score}"
							player.total_money -= player_bet
							puts 
							puts "You bet $#{player_bet}, total money, $#{player.total_money}"
							puts
							return bust
						else
							puts "####################" 
							puts "#{@player.name}'s Hand: #{@player.hand}" 
							puts "Total: #{@player.check_score}"
						end
					end
				end
				dealers_turn(player_bet)
			end
		end
	end

	def dealers_turn(player_bet)
		puts
		puts "#{@player.name}'s turn is over. Dealers Turn."
		
		until @dealer.check_score > 17
			puts "Dealer draws..."
			@dealer.hand.push(@current_deck.shift)
		end
		if @dealer.check_score > 21
			puts "####################"
			puts "Dealer busts!"
			puts "Dealers Hand: #{@dealer.hand}" 
			puts "Total: #{@dealer.check_score}"
			player.total_money += player_bet
			puts 
			puts "You bet $#{player_bet}, total money, $#{player.total_money}"
			puts
			return bust
		end
		win_condition(player_bet)
	end

	def win_condition(player_bet)

		if @player.check_score > @dealer.check_score
			puts
			puts "####################"
			puts "#{@player.name} wins!!"
			puts "#{@player.name}'s Hand: #{@player.hand}" 
			puts "Dealers Hand: #{@dealer.hand}" 
			puts "#{@player.check_score} beats #{@dealer.check_score}."
			player.total_money += player_bet
			puts 
			puts "You bet $#{player_bet}, total money, $#{player.total_money}"
			puts "####################"
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
			puts "####################"
			puts "Dealer wins!!"
			puts "Dealers Hand: #{@dealer.hand}" 
			puts "#{@player.name}'s Hand: #{@player.hand}"
			puts "#{@dealer.check_score} beats #{@player.check_score}."
			player.total_money -= player_bet
			puts 
			puts "You bet $#{player_bet}, total money, $#{player.total_money}"
			puts "####################"
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
			puts "####################"
			puts "It's a tie!!"
			puts "#{@player.name}'s Hand: #{@player.hand}"
			puts "Dealers Hand: #{@dealer.hand}" 
			puts "#{@dealer.check_score} equals #{@player.check_score}."
			puts "You bet $#{player_bet}, total money, $#{player.total_money}"
			puts "####################"
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
	end

end

class Player
	# 
	attr_accessor :name, :total_money, :hand, :player_score

	def initialize
		@hand = []
		@player_score = 0
	end

	def check_score
		@player_score = 0
		@hand.each { |card| @player_score += card }
		@player_score
	end
end



class Dealer
	attr_accessor :balance, :hand, :visible_card, :dealer_score

	def initialize
		@hand = []
		@dealer_score = 0
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
		@cards = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
	end
end

player = Player.new()
dealer = Dealer.new()
games = Blackjack.new(player,dealer)
games.start