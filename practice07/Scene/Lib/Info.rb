class Info
    attr_accessor :score,:timer
    def initialize(timer:,score:,playerlife:,stage:)
        @score = score
        @playerlife = playerlife
        @timer = timer
        @font = Font.new(30,'MSゴシック')
        @stage = stage
    end

    def update
        Window.draw_font(0,0,"SCORE:#{@score}",@font)
        Window.draw_font(200,0,"LIFE:#{@playerlife}",@font)
        Window.draw_font(400,0,"TIME:#{sprintf("%.1f",@timer)}",@font)
        Window.draw_font(300,300,"STAGE:#{@stage}",@font)
        @timer -= 1/60.to_f
    end
end
