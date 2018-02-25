require_relative '../scene_game/Director'
require_relative '../info/Score'

module Gameover
    class Director
        def initialize
            @font = Font.new(30,'MSゴシック')
        end

        def play
            Window.draw_font(200,200,"GameOverです！",@font)
            Window.draw_font(200,300,"あなたのスコアは#{Score.get_score}点でした。",@font)
            Window.draw_font(200,400,"スペースキーでタイトルへ戻ります。",@font)

            if Input.key_push?(K_SPACE)
                Scene.add(Title::Director.new, :title)
                Scene.add(Game::Director.new, :game)
                Scene.add(Gameover::Director.new, :gameover)
                Scene.move_to(:title)
            end
        end
    end
end
