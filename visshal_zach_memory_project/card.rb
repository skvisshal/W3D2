class Card

    attr_reader :face_up, :face_value
    def initialize(face_value)
        @face_value = face_value
        @face_up = false
    end

    def hide
        @face_up = true
    end

    def reveal
        @face_up = true
    end

    def to_s
        @face_value.to_s
    end

    def ==(card)
        self.to_s == card.to_s
    end
end