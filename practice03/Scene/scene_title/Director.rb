
module Title
    class Director
        def initialize
            @font = Font.new(60,'MSゴシック')
        end

        def play
            Window.draw_font(250,200,"あくしょんゲーム的ななにか",@font)
            Window.draw_font(250,400,"SPACEキーでスタート",@font)
            if Input.key_push?(K_SPACE)
                #BGM.play
                Scene.move_to(:game)
            end
        end
    end
end
