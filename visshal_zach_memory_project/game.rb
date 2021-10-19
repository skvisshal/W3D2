require_relative "board.rb"
require_relative "card.rb"
require_relative "player.rb"



class Game

    def self.get_response
        puts "Enter a size for the board"
        response = gets.chomp.to_i
    end
    
    def initialize
        @board = Board.new(Game.get_response)
        @board.populate
        @player_1 = Player.new(:h, @board.length)
        @player_2 = Player.new(:c, @board.length)
        @current_player = @player_1
    end 

    def play
        @board.render
        loop do
            if @current_player.type == :h
                puts "Please enter a position of the card you'd like to flip for the 1st guess"
                pos = gets.chomp.split.map! {|ele| ele.to_i}
            else
                pos = @current_player.get_pos
            end
            next if !self.make_first_guess(pos)
            if @current_player.type == :h
                loop do 
                    puts "Please enter a position of the card you'd like to flip for the 2nd guess"
                    pos_2 = gets.chomp.split.map! {|ele| ele.to_i}
                    if !self.make_second_guess(pos_2)
                        next
                    else
                        break
                    end
                end
            else
                self.make_second_guess(@current_player.get_pos)
            end
                
            break if @board.won?
        end
        puts "Game Over"
    end

    def make_first_guess(pos)
        return false if !@board.reveal(pos)
        @current_player.previous_guess << pos
        @board.render
        true
    end

    def make_second_guess(pos)
        return false if !@board.reveal(pos)
        @board.reveal(@current_player.previous_guess.last)
        @board.render
        puts
        if @board[pos] != @board[@current_player.previous_guess.last]
            @board[pos].hide
            @board[@current_player.previous_guess.last].hide
            @board.render
        end
        true
    end

    def switch_player!
        if @current_player == @player_1
            @current_player = @player_2
        else
            @current_player = @player_1
        end
    end

end

g = Game.new
g.play