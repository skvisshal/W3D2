require_relative "board.rb"
require_relative "card.rb"

class Game

    def self.get_response
        puts "Enter a size for the board"
        response = gets.chomp.to_i
    end
    
    def initialize
        @board = Board.new(Game.get_response)
        @board.populate
        @previous_guess = []
        @first_guess = true
    end 

    def play
        @board.render
        loop do
            puts "Please enter a position of the card you'd like to flip for the 1st guess"
            pos = gets.chomp.split.map! {|ele| ele.to_i}
            next if !self.make_first_guess(pos)
            loop do 
                puts "Please enter a position of the card you'd like to flip for the 2nd guess"
                pos_2 = gets.chomp.split.map! {|ele| ele.to_i}
                if !self.make_second_guess(pos_2)
                    next
                else
                    break
                end
            end
            break if @board.won?
        end
        puts "Game Over"
    end

    def make_first_guess(pos)
        return false if !@board.reveal(pos)
        @previous_guess << pos
        @board.render
        true
    end

    def make_second_guess(pos)
        return false if !@board.reveal(pos)
        @board.reveal(@previous_guess.last)
        @board.render
        puts
        if @board[pos] != @board[@previous_guess.last]
            @board[pos].hide
            @board[@previous_guess.last].hide
            @board.render
        end
        true
    end
end

g = Game.new
g.play