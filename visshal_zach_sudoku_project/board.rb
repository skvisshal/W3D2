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
        @grid = grid.map do |row|
            row.map do |ele|
                if ele == 0
                    Tile.new(ele, false)
                else
                    Tile.new(ele, true)
                end
            end
        end
    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos, val)
        @grid[pos[0]][pos[1]].value = val
    end

    def render
        print "-------------------------\n"
        @grid.each_with_index do |row, i|
            print "| "
            row.each_with_index do |ele, j|
                if ele.value == 0
                    print "_ "
                else
                    print "#{ele.value} "
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
        win_row? && win_col? && win_box?
    end

    def win_row?
        @grid.all? do |row|
            row.inject(0){ |acc, ele| acc += ele.value } == 45
        end
    end

    def win_col?
        @grid.transpose.all? do |row|
            row.inject(0){ |acc, ele| acc += ele.value } == 45
        end
    end

    def win_box?
        result_arr = Array.new(3) {Array.new(3) {[]}}
        @grid.each.with_index do |row, i|
            row.each_with_index do |col, j|
                result_row = i / 3
                result_col = j / 3
                result_arr[result_row][result_col] << col
            end
        end
        result_arr.all? do |row|
            row.all? do |box|
               box.inject(0){ |acc, ele| acc += ele.value } == 45
            end
        end
    end

    def legal_move?(pos, val)
        if @grid[pos[0]][pos[1]].value != 0
            return false
        elsif val < 1 || val > 9
            return false
        elsif dup_row_val?(pos, val) || dup_col_val?(pos, val) || dup_box_val?(pos, val)
            return false
        else
            return true
        end
    end

    def dup_row_val?(pos, val)
        return true if @grid[pos[0]].include?(val)
    end

    def dup_col_val?(pos, val)
        return true if @grid.transpose[pos[1]].include?(val)
    end

    def dup_box_val?(pos, val)
        result_arr = Array.new(3) {Array.new(3) {[]}}
        @grid.each.with_index do |row, i|
            row.each_with_index do |col, j|
                result_row = i / 3
                result_col = j / 3
                result_arr[result_row][result_col] << col
            end
        end
        result_row = pos[0] / 3
        result_col = pos[1] / 3
        return true if result_arr[result_row][result_col].include?(val)
    end


end

# grid = Board.from_file("sudoku1_solved.txt")
# b = Board.new(grid)
# b.render
# p b.solved?