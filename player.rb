class Player
	def initialize(name, board)
		@name = name
		@board = board
		@guesses = 0
		@wrong = 0
		@right = 0
	end
	
	def name
		@name
	end
	
	# The number of guesses taken
	def guesses
		@guesses
	end
	
	# The number of wrong guesses
	def wrong
		@wrong
	end
	
	# A correct guess adds 1 to the right variable
	def correct!
		guess!
		@right += 1
	end
	
	# Incorrect does the opposite
	def incorrect!
		guess!
		@wrong += 1
	end
	
	# Log a new guess
	def guess!
		@guesses += 1
	end
	
	# Has the player lost?
	def lost?
		@wrong >= 6
	end
	
	# Let's process a guess
	def guess?(letter)
		status = false
		found_first = false # We don't want to mark a letter with multiple matches as correct more than once
		@board.phrase.letters.each_with_index do |l,i|
			if l == letter
				@board.mark_correct(l, i)
				correct! unless found_first # Only mark as correct the first time
				found_first = true
				status = true
			end
		end
		
		# If the letter wasn't found, mark the guess as incorrect
		if status == false
			# But only if they haven't guessed it before
			unless @board.already_guessed?(letter)
				@board.incorrect=(letter)
				incorrect!
			end
		end
		
		return status
	end
	
	# Has the player won?
	def won?
		# Create a new array to check against.
		# This new array has to match the letters array to validate
		correct_array = @board.correct.map {
			|l| l.size == 2 ? l = l[0,1] : l = l
		}
		@board.phrase.letters - correct_array == []
		
	end
end