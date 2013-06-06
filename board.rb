class Board
	def initialize
		@phrase = Phrase.new(self)
		@correct = build_correct_array
		@incorrect = []
		@spaces = ""
	end
	
	def correct
		@correct
	end
	
	def incorrect
		@incorrect
	end
	
	def mark_correct(letter, index)
		@correct[index] = "#{letter} "
	end
	
	def incorrect=(letter)
		@incorrect << letter
	end
	
	def phrase
		@phrase
	end
	
	def already_guessed?(letter)
		@incorrect.each {|l| return true if l == letter}
		return false
	end
	
	# Build the array of correct letters
	def build_correct_array
		array = []
		@phrase.letters.each {|l| array << l.gsub(/[!^a-zA-Z]/, "_ ")}
		array
	end
	
	# Creating the board
	def flash(message)
		puts "#############################################"
		puts "#{message}"
		puts "#############################################"
	end
	
	def man(num)
		puts "  -----------                    Letters used"
		puts "  |       | |                    ------------"
		puts "  #{num > 0 ? 'O' : ' '}       | |                    #{@incorrect}            "
		puts " #{num > 2 ? '/' : ' '}#{num > 1 ? '|' : ' '}#{num > 3 ? '\\' : ' '}      | |                                "
		puts "  #{num > 1 ? '|' : ' '}       | |                                "
		puts " #{num > 4 ? '/' : ' '} #{num > 5 ? '\\' : ' '}      | |                                "
		puts "          | |                                "
		puts " _________| |                                "
		puts " ____________                                "
		puts " "
	end
	
	# Show the letter spaces
	def spaces
		@correct.to_s
	end
	
	def head
		"O"
	end
	
	def torso
		"|"
	end
	
	def right_limb
		"\\"
	end
	
	def left_limb
		"/"
	end
end