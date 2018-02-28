class Score
    attr_accessor :score
    def initialize(score)
        @@score = score
    end

    def update
        Window.draw_font(150,10,"Score: #{@@score}",Font.default)
    end

    def self.get_score
        return @@score
    end

    def addScore
        @@score += 100
    end
end
