class Score
    attr_accessor :score
    def initialize
        @font = Font.new(50,'MS明朝')
        @score = 0
    end

    def update
        Window.draw_font(300,300,"SCORE:#{@score}",@font)
    end
end
