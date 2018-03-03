require_relative '../Lib/Player'
require_relative '../Lib/Enemy'
require_relative '../Lib/Info'
require_relative '../scene_gameover/Director'

module Game2
    class Director < Game1::Director
        def initialize
            super
            @info = Info.new(timer:20,score:0,playerlife:3,stage:2)
            @enemyshots = Enemy.get_enemyshots
        end
        def play
            super
            #敵の弾とプレイヤーの衝突判定
            if Sprite.check(@enemyshots,@player)
                DAMAGE_SOUND.play
                @info.score -= 100
                @info.playerlife -= 1
            end
            Sprite.update([@enemyshots])
            Enemy.generator(count:@count,enemies:@enemies,num: 500,count_rand: 300)
            # Enemy.shot_generator(@count,@enemyshot,1000)
            #衝突判定で消えたオブジェクトを配列から削除
            Sprite.clean([@enemyshots])
        end
    end
end
