require_relative '../scene_game/Director'
require_relative '../info/Score'

module Gameover
    class Director
        @@game_stage_maneger = 0
        def initialize
            @font = Font.new(30,'MSゴシック')
        end

        def play
            Window.draw_font(200,200,"GameOverです！",@font)
            Window.draw_font(200,300,"あなたのスコアは#{Score.get_score}点でした。",@font)
            if @@game_stage_maneger < 1
                Window.draw_font(200,400,"スペースキーでステージ#{@@game_stage_maneger+2}へ。",@font)
            else
                Window.draw_font(200,400,"スペースキーでタイトルへ。",@font)
            end

            if Input.key_push?(K_SPACE)

                #次のステージへ移行
                if @@game_stage_maneger == 0
                    BGM.play
                    @@game_stage_maneger += 1
                    Scene.move_to(:game2)
                else
                    #シーンのリセット
                    Scene.add(Title::Director.new, :title)
                    Scene.add(Game::Director.new, :game)
                    Scene.add(Gameover::Director.new, :gameover)
                    Scene.add(Game2::Director.new, :game2)
                    @@game_stage_maneger = 0
                    Scene.move_to(:title)
                end
            end
        end
    end
end
