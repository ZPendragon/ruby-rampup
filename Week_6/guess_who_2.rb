class Player

	@@suspect_pool = list_of_suspects 

	attr_accessor :guilty, :list_of_suspects

end

class Suspect
	
	attr_accessor :name, :gender, :skin_color, :hair_color, :eye_color, :face_down

	@face_down = false

end

class Game

	attr_accessor :turn_count 
	attr_reader :list_of_suspects

	def initialize 
		turn_count = 0
		load_suspects
		add_player
	end

	private
	def load_suspects
		f = File.read('suspect.csv')
		parsed = CSV.parse(f)
		@list_of_suspects = []
		parsed.each { |name, gen, skin, hair, eye| @list_of_suspects.push Suspect.new(name,gen,skin,hair,eye) }
	end

	def add_player
		2.times do 
			Player.new
			Player.list_of_suspects = @list_of_suspects
		end
	end

	def pick_guilty_suspects

	end
end