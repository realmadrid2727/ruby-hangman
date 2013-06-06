class Phrase
	def initialize(board)
		@board = board
		@solution = selection
		@letters = []
		@solution.each {|l| @letters << l.gsub(/[^a-zA-Z ]/, "")}
	end
	
	def selection
		seed = phrases.length # Get the number of phrases
		phrases[rand(seed)].split("").map {|x| x.upcase} # And use that for a random index
	end
	
	def letters
		@letters
	end
	
	def show
		@letters.to_s
	end
	
	# Return the number of letters in the phrase
	def letter_count(spaces = true)
		if spaces
			@letters.length
		elsif !!spaces
			@letters.to_s.gsub(/[^a-zA-Z]/,"").length
		end
	end
	
	# Returns true if the letter exists
	def letter?(guess)
		@letters.each {|l| return true if l == guess}
		return false
	end
	
	def phrases
		lines = []
		file = File.open('phrases.dat', 'r').each {|line| lines << line.chomp }
		file.close
		return lines
	end
end