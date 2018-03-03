require_relative '../Lib/Player'
require_relative '../Lib/Enemy'
require_relative '../Lib/Info'
require_relative '../Lib/Button'
require_relative '../scene_gameover/Director'

module Game
    class Director
        def initialize
            @player = Player.new
            @playershots = []
            @enemies = []
            @timer = 0
            @info = Info.new(timer:5,score:0,playerlife:3,stage:1)
        end
        def play

            @player.update(@playershots)
            @info.update
            Sprite.update([@playershots,@enemies])

            #プレイヤーの弾と敵の衝突判定
            if Sprite.check(@playershots,@enemies)
                EXPLOSION_SOUND.play
                @info.score += 100
            end

            #敵の出現
            if @timer % 1000 == 0
                @enemies << Enemy.new
            end

            @timer += 10

            #衝突判定で消えたオブジェクトを配列から削除
            Sprite.clean([@player,@enemies,@playershots])

            #終了処理
            if @info.timer <= 0
                BGM_SOUND.stop 
                Scene.move_to(:gameover)
            end
        end
    end
end
