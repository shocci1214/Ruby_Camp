require_relative '../Lib/Button'
require_relative '../Lib/Info'
module GameOver
    class Director
        @@score = 0
        def initialize
            @button_next = Button.new(200,200,'次のステージへ',START_SOUND,to: "game")
            @button_to_title = BackButton.new(200,300,'タイトルへもどる',EXIT_SOUND,to:'title')
        end

        def self.set_score(score)
            @@score = score
        end

        def self.stage_change
            Button.stage_count
        end

        def play
            Window.draw_font(100,100,"あなたの得点は#{@@score}点でした",Font.default)
            @button_next.update
            @button_to_title.update
        end
    end
end
