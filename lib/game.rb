class Game 

	def initialize
		@players = []
		@started = false
	end

	def add(player)
		@players << player
	end

	def started?
		@started
	end

	def start!
		@started = true
	end

	BEATS = {rock: :scissors, scissors: :paper, paper: :rock}

	attr_reader :players

	def winner
		return "Draw" if players[0].pick == players[1].pick
		return players[0] if BEATS[normalize(players[0].pick)] == normalize(players[1].pick)
		players[1]
	end

	def normalize(pick)
		pick.downcase.to_sym
	end

	def get_player(name)
		@players.select { |player| player.name == name}.first
	end

	def game_over?
		return true if @players[0].score == 5 || @players[1].score == 5
		false
	end
end