class Player < Sprite
    def initialize
        super
        self.x = 100
        self.y = 400
        self.image = Image.new(40,80).box_fill(0,0,40,80,[255,0,0,255])
    end
    def update(playershot)
        self.draw
        #矢印キーで移動
        if Input.key_down?(K_RIGHT)
            self.x += 10
        elsif Input.key_down?(K_LEFT)
            self.x -= 10
        end

        #移動の制限
        self.x = 600 if self.x > 600
        self.x = 0 if self.x < 0

        #弾の発射
        if Input.key_push?(K_Z)
            PLAYER_SHOT_SOUND.play
            playershot << PlayerShot.new(self.x,self.y)
        end
    end
end

class PlayerShot < Sprite
    def initialize(x,y)
        super
        self.x = x + 10
        self.y = y - 15
        self.image = Image.new(20,20).circle_fill(10,10,9,[255,255,255,255])
    end
    def update
        self.draw
        self.y -= 10

        #弾が画面外に出たとき消滅させる
        if self.y < 0
            self.vanish
        end
    end

    def shot
        self.vanish
    end
end
