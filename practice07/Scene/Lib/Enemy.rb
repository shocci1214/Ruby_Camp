class Enemy < Sprite
    @@enemyshots = []
    def initialize(count_rand)
        super
        self.x = 50
        self.y = 30
        self.image = Image.new(50,50).box_fill(0,0,50,50,[255,255,0,0])
        @count = 0
        @num = count_rand
        @timer = 0
    end

    def self.generator(count:,enemies:,num:500,count_rand:10)
        if count % num == 0
            enemies << Enemy.new(count_rand)
        end
    end

    def self.get_enemyshots
        @@enemyshots
    end

    def self.reset_enemyshots
        @@enemyshots.clear
    end

    def update
        #描画
        self.draw
        #敵機の移動
        self.x += 5
        #敵機の弾の発射
        if @timer >= 30
            if @timer % rand(17..20) == 0
                if @count % rand(1..@num) == 0
                    @@enemyshots << EnemyShot.new(self.x,self.y)
                end
            end
        end

        #画面右端で消滅
        if self.x > 640
            self.vanish
        end

        @count += 10
        @timer += 1
    end

    def hit
        self.vanish
    end
end


#敵の弾クラス
class EnemyShot < Sprite
    @@enemyshots = []
    def initialize(x,y)
        super
        self.x = x + 30
        self.y = y
        self.image = Image.new(20,20).circle_fill(10,10,9,[255,255,0,0])

    end


    def update

        #弾が画面外に出たとき消滅
        if self.y > 480
            self.vanish
        end

        self.draw
        self.y += 8
    end

    def shot(obj)
        self.vanish
    end
end
