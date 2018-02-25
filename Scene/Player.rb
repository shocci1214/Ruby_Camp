class Player < Sprite
    def initialize
        super
        self.image = Image.new(40,80).box_fill(0,0,39,79,[255,0,0,255])
        self.x = 400
        self.y = 500
    end

    def update
        #描画
        self.draw
        #矢印キーで移動（移動の制限）
        if Input.key_down?(K_LEFT) && self.x > 0
            self.x -= 15
        elsif Input.key_down?(K_RIGHT) && self.x < Window.width - 40
            self.x += 15
        elsif Input.key_down?(K_UP) && self.y > 0
            self.y -= 15
        elsif Input.key_down?(K_DOWN) && self.y < Window.height - 80
            self.y += 15
        end

        #弾の発射
        if Input.key_push?(K_Z)
            # $PlayerShot << PlayerShot.new(self.x,self.y)
            PlayerShot.get_playershot << PlayerShot.new(self.x,self.y)
            PLAYERSHOT_SOUND.play
        end

    end
end


class PlayerShot < Sprite
    @@playershot = []
    def initialize(x,y)
        super
        self.image = Image.new(20,20).circle_fill(10,10,9,[255,255,255,255])
        self.x = x + 10
        self.y = y - 15
    end

    def self.get_playershot
        return @@playershot
    end

    def update
        self.draw
        self.y -= 10

        #弾が画面外に出たとき消滅させる
        if self.y < 0
            self.vanish
        end
    end

    def shot(obj)
        self.vanish
    end
end
