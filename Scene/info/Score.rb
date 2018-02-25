class Score
    attr_accessor :score
    def initialize(score)
        @score = score
    end

    def update
        Window.draw_font(150,10,"Score: #{@score}",Font.default)
    end
end
