require_relative '../Player'
require_relative '../Enemy'
require_relative '../info/Timer'
require_relative '../info/Score'

module Game
    class Director
        attr_accessor :timer
        #敵の出現用変数
        @@count = 0
        #プレイヤーの弾
        @@playershot = PlayerShot.get_playershot
        #敵配列
        @@enemies = Enemy.get_enemies

        def initialize
            @player = Player.new
            @timer = Timer.new(10)
            @score = Score.new(0)
        end


        def play
            @player.update
            @timer.update
            @score.update
            Sprite.update([@@playershot,@@enemies])

            #敵の出現
            @@count += 1
            if @@count % 50 == 0
                @@enemies << Enemy.new
            end

            #プレイヤーの弾と敵機の衝突判定
            #衝突したとき、$PlayerShotのshotメソッドと、$enemyのhitメソッドを呼び出す
            if Sprite.check(@@playershot,@@enemies)
                @score.addScore
                EXPLOSION_SOUND.play
            end

            #ゲームオーバー
            if @timer.time <= 0
                #プレイヤーの弾を次のステージに残さないようにしたいがうまくいかない 次のステージで撃てなくなる
                # @@playershot = []
                @@enemies = []
                BGM.stop
                Scene.move_to(:gameover)
            end
        end
    end
end
