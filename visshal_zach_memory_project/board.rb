require_relative "card.rb"

class Board

    def initialize(size)
        raise "size must be even" if size.odd?
        @grid = Array.new(size) {Array.new(size)}
    end

    FACE_VALUES = ("A".."Z").to_a

    def populate
        @grid.each do |row|
            i = 0
            while i < row.length
                face_value = FACE_VALUES.sample
                row[i] = Card.new(face_value)
                row[i + 1] = Card.new(face_value)
                i += 2
            end
        end
        @grid.map! { |row| row.shuffle}
        @grid = @grid.transpose.map! { |row| row.shuffle}
    end

    def render
        @grid.each do |row|
            row.each do |card|
                print card.face_value
            end
            print "\n"
        end
    end

end

b = Board.new(6)
b.populate
b.render