class Player

    attr_reader :type, :previous_guess

    def initialize(type, size)
        @type = type
        @previous_guess = []
        @known_cards = {}
        @size = size
    end

    def get_pos
        result = []
        if !@known_cards.empty?
            row = rand(0...@size)
            col = rand(0...@size)
            result << [row, col]
            row = rand(0...@size)
            col = rand(0...@size)
            result << [row, col]
        elsif @known_cards.any? { |k, v| v.length > 1 }
            hash = @known_cards.select { |k, v| v.length > 1 }
            hash.each do |k, v|
                result << v[0], v[1]
                break
            end
        else
            @known_cards.each do |k, v|
                result << v[0]
                break
            end
            row = rand(0...@size)
            col = rand(0...@size)
            result << [row, col]
        end

        result.first(2)
    end

    def alter_known_cards



end