require 'csv'

class Guess_who

	attr_accessor :people, :suspect, :guess_count, :suspect_count
	
	def initialize
		f = File.read('suspect.csv')
		parsed = CSV.parse(f)
		@people = []
		@guess_count = 0
		parsed.each { |name, gen, skin, hair, eye| @people.push Person.new(name,gen,skin,hair,eye) }
		@people.delete_at(0)
		@suspect_count = @people.count - 1
		@suspect_count = suspect_count.to_i
		@suspect = @people[rand(0..@suspect_count)]
		# puts suspect_count
		# puts suspect.name
		# puts suspect.gender
	end

	def start
		puts "############################################################"
		puts "Welcome to Guess Who -- The game of clues"
		puts 
		puts "You have three turns to successfully identify who killed the butler!."
		puts "With every incorrect guess, the suspects with the same guessed attribute are removed."
		puts "Good luck!"
		puts "############################################################"
		puts 
		puts "Would you like to play Guess Who? ( Yes | No ):"
		player_input = gets.chomp
		if player_input.downcase == 'yes'
			puts
			puts
			play
		elsif player_input.downcase == "no"
			puts "Okay. Next time."
		else 
			puts "Not gonna try to guess what you meant..."	
		end
	end

	def play
		@guess_count += 1
		if @guess_count <= 3
			puts "############################################################"
			puts "Outstanding Suspects"
			puts
			0.upto(@suspect_count) do |num|
				suspect_num = num + 1 
				puts "Suspect #{suspect_num}: #{people[num].name}, #{people[num].gender}, #{people[num].skin_color}, #{people[num].hair_color}, #{people[num].eye_color} "
			end
			puts "############################################################"
			check_attribute
		else
			puts "############################################################"
			puts "You ran out of turns!!! You must now guess the suspect!"
			guess
		end
	end

	def check_attribute
		puts "Select an attribute (gender, skin, hair, eyes) or GUESS???"
		player_input = gets.chomp.downcase
		case player_input
		when "gender"
			check_gender
		when "skin"
			check_skin
		when "hair"
			check_hair
		when "eyes"
			check_eyes
		when "guess"
			guess
		else
			puts "Sorry. That's not an attribute."
			check_attribute
		end
	end

	def check_gender
		puts "As Professor Oak would say, boy or girl?"
		gender_input = gets.chomp.downcase
		possible_gender = ["boy","girl"]
		if gender_input == @suspect.gender.strip
			puts "Correct. The suspect is a #{gender_input}."
			people.delete_if { |person| person.gender.strip != gender_input }
			@suspect_count = @people.count - 1
			play
		elsif possible_gender.each { |gender| gender == gender_input }
			puts "Incorrect. The suspect is not a #{gender_input}."
			puts "Removing suspects that are #{gender_input}s."
			people.delete_if { |person| person.gender.strip == gender_input }
			@suspect_count = @people.count - 1
			play
		else
			puts "Sorry. That's not a valid gender."
			check_gender
		end
	end

	def check_skin
		puts "Pick a skin color ( White | Black )"
		skin_input = gets.chomp.downcase
		possible_skin = ["white","black"]
		if skin_input == @suspect.skin_color.strip
			puts "Correct. The suspect is a #{skin_input}."
			people.delete_if { |person| person.skin_color.strip != skin_input }
			@suspect_count = @people.count - 1
			play
		elsif possible_skin.each { |skin| skin == skin_input }
			puts "Incorrect. The suspect is not #{skin_input}."
			puts "Removing suspects that are #{skin_input}."
			people.delete_if { |person| person.skin_color.strip == skin_input }
			@suspect_count = @people.count - 1
			play
		else
			puts "Sorry. That's not a valid skin color."
			check_skin
		end
	end

	def check_hair
		puts "Pick a hair color ( Auburn | Black | Blonde | Brown )"
		hair_input = gets.chomp.downcase
		possible_hair = ["auburn","black","blonde","brown"]
		if hair_input == @suspect.hair_color.strip
			puts "Correct. The suspect has #{hair_input} hair."
			people.delete_if { |person| person.hair_color.strip != hair_input }
			@suspect_count = @people.count - 1
			play
		elsif possible_hair.each { |hair| hair == hair_input }
			puts "Incorrect. The suspect does not have #{hair_input} hair."
			puts "Removing suspects that have #{hair_input} hair."
			people.delete_if { |person| person.hair_color.strip == hair_input }
			@suspect_count = @people.count - 1
			play
		else
			puts "Sorry. That's not a valid hair color."
			check_hair
		end
	end

	def check_eyes
		puts "Pick an eye color ( Blue | Brown | Green )"
		eye_input = gets.chomp.downcase
		possible_eye = ["blue","brown","green"]
		if eye_input == @suspect.eye_color.strip
			puts "Correct. The suspect has #{eye_input} eyes."
			people.delete_if { |person| person.eye_color.strip != eye_input }
			@suspect_count = @people.count - 1
			play
		elsif possible_eye.each { |eye| eye == eye_input }
			puts "Incorrect. The suspect does not have #{eye_input} eyes."
			puts "Removing suspects that have #{eye_input} eyes."
			people.delete_if { |person| person.eye_color.strip == eye_input }
			@suspect_count = @people.count - 1
			play
		else
		puts "Sorry. That's not a valid eye color."
		check_eyes
		end
	end

	def guess
		puts "############################################################"
		puts "Outstanding Suspects"
		puts
		0.upto(@suspect_count) do |num|
			suspect_num = num + 1 
			puts "Suspect #{suspect_num}: #{people[num].name}, #{people[num].gender}, #{people[num].skin_color}, #{people[num].hair_color}, #{people[num].eye_color} "
		end
		puts "############################################################"
		puts "Who do you think killed the butler!?"
		guess_input = gets.chomp.downcase
		if guess_input == @suspect.name.strip
			puts "Correct!!! It was #{@suspect.name}!"
			play_again
		elsif guess_input != @suspect.name.strip && @guess_count > 3
			puts "GAME OVER"
			puts "You ran out of turns!!! The guilty suspect was #{@suspect.name}"
			play_again
		else
		puts "Sorry. That's wrong."
		people.delete_if { |person| person.name.strip != guess_input }
		play
		end
	end

	def play_again
		puts "Play Again? ( Yes | No )"
		player_input = gets.chomp
		if player_input.downcase == 'yes'
			f = File.read('suspect.csv')
			parsed = CSV.parse(f)
			@people = []
			@guess_count = 0
			parsed.each { |name, gen, skin, hair, eye| @people.push Person.new(name,gen,skin,hair,eye) }
			@people.delete_at(0)
			@suspect_count = @people.count - 1
			@suspect_count = suspect_count.to_i
			@suspect = @people[rand(0..@suspect_count)]
			puts
			puts
			play
		elsif player_input.downcase == "no"
			puts "Okay. Thanks for playing Guess Who!"
		else 
			puts "Not gonna try to guess what you meant..."	
		end
	end

end

class Person 
	attr_accessor :name, :gender, :skin_color,  :hair_color, :eye_color

	def initialize(name,gender,skin_color,hair_color,eye_color)
		@name = name
		@hair_color = hair_color
		@eye_color = eye_color
		@skin_color = skin_color
		@gender = gender
	end

end

game = Guess_who.new()
game.start