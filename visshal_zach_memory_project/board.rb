require_relative "card.rb"

class Board

    def initialize(size)
        raise "size must be even" if size.odd?
        @grid = Array.new(size) {Array.new(size)}
    end

    FACE_VALUES = ("A".."Z").to_a

    def populate
        random_array = FACE_VALUES.sample((@grid.length**2)/2)
        j = 0
        @grid.each do |row|
            i = 0
            while i < row.length
                face_value = random_array[j]
                row[i] = Card.new(face_value)
                row[i + 1] = Card.new(face_value)
                i += 2
                j += 1
            end
        end
        @grid.map! { |row| row.shuffle}
        @grid = @grid.transpose.map! { |row| row.shuffle}
    end

    def render
        @grid.each do |row|
            row.each do |card|
                if card.face_up
                    print card.face_value
                else
                    print "_"
                end
            end
            print "\n"
        end
    end

    def won?
        @grid.all? do |row|
            row.all? do |card|
                card.face_up
            end
        end
    end

    def reveal(guessed_pos)
        card_pos = @grid[guessed_pos[0]][guessed_pos[1]]
        if !card_pos.face_up
            card_pos.reveal 
            return card_pos.to_s
        end
        return false
    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

end

