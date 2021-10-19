class Tile

    attr_reader :value, :given
    def initialize(value, given)
        @value = value
        @given = given
    end

    def value=(value)
        raise "Tile is already Given" if @given
        @value = value
    end
end
