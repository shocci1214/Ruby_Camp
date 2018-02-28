module Title
    class Director
        def initialize
            @font = Font.new(40,'MS明朝')
        end

        def play
            Window.draw_font(150,100,"ブロックくずし",@font)
            Window.draw_font(150,200,"SPACEキーでスタート",@font)
            if Input.key_push?(K_SPACE)
                Scene.move_to(:game)
            end
        end
    end
end
