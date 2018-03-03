require_relative '../Lib/Button'
module GameOver
    class Director
        def initialize
            @button_next = Button.new(200,200,'次のステージへ',START_SOUND,to: "game")
            @button_to_title = BackButton.new(200,300,'タイトルへもどる',EXIT_SOUND,to:'title')
        end

        def self.stage_change
            Button.stage_count
        end

        def play
            Window.draw_font(100,100,'GameOverです',Font.default)
            @button_next.update
            @button_to_title.update
        end
    end
end
