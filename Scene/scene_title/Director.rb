
module Title
    class Director
        def initialize
            @font = Font.new(30,'MSゴシック')
        end

        def play
            Window.draw_font(200,200,"タイトル画面です！",@font)
            Scene.move_to(:game) if Input.key_push?(K_SPACE)
        end
    end
end
