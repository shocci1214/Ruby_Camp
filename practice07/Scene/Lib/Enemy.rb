class Enemy < Sprite
    def initialize
        super
        self.x = 50
        self.y = 30
        self.image = Image.new(50,50).box_fill(0,0,50,50,[255,255,0,0])
    end

    def self.generator(count,enemies)
        if count % 1000 == 0
            enemies << Enemy.new
        end
    end

    def update
        #描画
        self.draw
        #敵機の移動
        self.x += 5
        #敵機の弾の発射

        #画面右端で消滅
        if self.x > 640
            self.vanish
        end
    end

    def hit
        self.vanish
    end
end


#敵の弾クラス
class EnemyShot < Sprite
    def initialize(x,y)
        super
        self.x = x + 30
        self.y = y
        self.image = Image.new(20,20).circle_fill(10,10,9,[255,255,0,0])
    end

    def update
        self.draw
        self.y += 8

        #弾が画面外に出たとき消滅
        if self.y > 480
            self.vanish
        end
    end
end
