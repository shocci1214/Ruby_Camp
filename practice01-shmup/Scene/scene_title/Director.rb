
module Title
    class Director
        def initialize
            @font = Font.new(30,'MSゴシック')
        end

        def play
            Window.draw_font(200,200,"シューティングゲームてきななにか",@font)
            if Input.key_push?(K_SPACE)
                BGM.play
                Scene.move_to(:game)
            end
        end
    end
end
