require_relative '../Lib/Button'
module Title
    class Director
        def initialize
            #Font
            @font_title = Font.new(30,'MSゴシック')
            #Buttton
            @button_start = Button.new(200,200,'START',START_SOUND,to: 'game')
            @button_exit = BackButton.new(200,300,'EXIT',EXIT_SOUND,to: 'exit')
        end

        def play
            Window.draw_font(200,100,'たいとるがめん',@font_title)
            @button_start.update
            @button_exit.update
            Window.draw_font(200,400,'←→で左右移動、Zキーで弾発射',@font_title)
        end
    end
end
