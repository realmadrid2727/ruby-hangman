#!/usr/bin/env ruby
require "player"
require "board"
require "phrase"
class Game
	def initialize
		@board = Board.new
		get_player
		game_loop
	end
	
	# Set up the player
	def get_player
		introduction
		@player = Player.new(gets.chomp, @board)
		refresh_screen
		@board.flash("Hey, #{@player.name}. I've selected a movie title. Let's begin.")
	end
	
	# Intro message
	def introduction
		#puts "#{@board.correct.inspect} #{@board.correct.length}"
		#puts "#{@board.phrase.letters.inspect} #{@board.phrase.letters.length}"
		refresh_screen
		puts "Welcome to hangman!"
		puts "What is your name?"
	end
	
	# Pick a letter
	def pick_letter
		puts "What letter would you like to guess?"
		@board.man(@player.wrong)
		puts @board.spaces
		return gets.chomp.upcase
	end
	
	# Check the letter
	def check_letter(letter)
		# Quick validation
		if letter.length > 1 || (letter =~ /^[a-zA-Z]/).nil?
			puts "Please enter a letter."
			return false
		end
		
		if @player.guess?(letter)
			return "You guessed correctly!"
		else
			return "WRONG GUESS!"
		end
	end
	
	# Status of the game
	def game_status(response)
		if @player.lost?
			@board.flash "Sorry, you lose! The answer was #{@board.phrase.show.upcase}"
			return play_again?
		elsif @player.won?
			@board.flash "You win! Awesome!"
			return play_again?
		else
			return true
		end
	end
	
	# Game over
	# Ask the player if they want to play again
	def play_again?
		puts "Want to play again? [Y/N]"
		while true
			response = gets.chomp.upcase
			case response
				when "Y"
					refresh_screen
					@board = Board.new
					@player = Player.new(@player.name, @board)
					return true
					break
				when "N"
					refresh_screen
					puts "Goodbye!"
					return false
					break
				else
					puts "Press 'Y' to play again or 'N' to quit."
			end
		end
	end
	
	# Game loop
	def game_loop
		running = true
		while (running)
			guess = pick_letter
			response = check_letter(guess)
			refresh_screen
			running = game_status(response)
		end
	end
	
private
	def refresh_screen
		system("clear")
	end
end

game = Game.new