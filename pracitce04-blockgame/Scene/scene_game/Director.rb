require_relative 'Bar'
require_relative 'Ball'
require_relative 'Block'
require_relative 'Wall'
require_relative '../Info/Score'

module Game
    class Director
        def initialize
            @state = 1
            @bar = Bar.new(200,430)
            @ball = Ball.new(400,300)
            @wall_color = [145,0,0]
            @walls = [
                Wall.new(0,0,Image.new(20,480,@wall_color)),
                Wall.new(0,0,Image.new(640,20,@wall_color)),
                Wall.new(620,0,Image.new(20,480,@wall_color)),
            ]
            @blocks = []
            @block_color = [C_BLUE,C_YELLOW,C_WHITE,C_RED,C_GREEN]
            5.times do |y|
                10.times do |x|
                    @blocks << Block.new(21 + 60 * x, 21 + 20 * y, @block_color[y])
                end
            end
            @score = Score.new
        end

        def play
            @bar.update
            @score.update
            @ball.update(@walls,@bar,@blocks)
            @ball.draw
            Sprite.draw(@walls)
            Sprite.draw(@blocks)
            Sprite.clean(@blocks)

            if Sprite.check(@ball,@blocks)
                @score.score += 100
                BLOCK_SOUND.play
            end


            if @ball.y > Window.height && @state == 1
                @state = 0
            end

            if @state == 0
                @ball.x  = @bar.x + @bar.image.width / 2
                @ball.y  = @bar.y - @ball.image.height
                if Input.key_push?(K_SPACE)
                    @state = 1
                end
            end
        end
    end
end
