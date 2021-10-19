require_relative "board.rb"
require_relative "tile.rb"

class Game

    def initialize(file_name)
        @board = Board.new(Board.from_file(file_name))
    end

    def prompt
        loop do
            @board.render
            puts "Enter an index and value"
            response = gets.chomp.split.map(&:to_i)
            pos = response[0..1]
            val = response[2]
            if @board.legal_move?(pos, val)
                @board[pos] = val
            else
                puts "not a valid move"
                next
            end
            break if @board.solved?
        end
        puts "Game Over"
    end



end

g = Game.new("sudoku1.txt")
g.prompt