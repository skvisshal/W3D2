require_relative "tile.rb"
class Board

    def self.from_file(file_name)
        file = File.open(file_name)
        file_data = file.readlines.map(&:chomp) #["0123456789", "23456788"]
        file.close
        file_data.map do |row|
            row.split("").map(&:to_i)
        end
    end

    def initialize(grid)
        @grid = grid
    end

    def []=(pos, val)
        @grid[pos[0]][pos[1]] = val
    end

    def render
        print "-------------------------\n"
        @grid.each_with_index do |row, i|
            print "| "
            row.each_with_index do |ele, j|
                if ele == 0
                    print "_ "
                else
                    print "#{ele} "
                end
                if (j + 1) % 3 == 0
                    print "| "
                end
            end
            print "\n"
            if (i+1) % 3 == 0
                print "-------------------------\n"
            end
        end
    end

    def solved?
        win_col? && win_row? && win_box?
    end

    def win_row?
        @grid.all? do |row|
            row.sum == 45
        end
    end

    def win_col?
        @grid.transpose.all? do |row|
            row.sum == 45
        end
    end

    def win_box?
        i = 0
        j = 0
        result = Array.new(9) {[]}
        while i < 9
            
        end
    end
end