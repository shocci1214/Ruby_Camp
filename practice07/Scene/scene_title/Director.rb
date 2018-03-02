require_relative 'Button'
module Title
    class Director
        def initialize
            #Font
            @font_title = Font.new(30,'MSゴシック')
            #Buttton
            @button_start = Button.new(200,200,'START',START_SOUND)
            @button_exit = ExitButton.new(200,300,'EXIT',EXIT_SOUND)
        end

        def play
            Window.draw_font(200,100,'たいとるがめん',@font_title)
            @button_start.update
            @button_exit.update
        end
    end
end
