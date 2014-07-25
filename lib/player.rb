class Player
	def initialize(name)
		@name = name
		@picks = ""
		@score = 0
	end

	attr_reader :name
	attr_writer :picks
	attr_accessor :score

	def pick
		@picks
	end

end