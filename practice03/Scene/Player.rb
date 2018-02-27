require_relative 'scene_game/Map'
class Player < Sprite
    def initialize(map)
        super
        self.x = 500
        self.y = 300
        self.image = Image.new(32,32,[255,255,0])
        @y_prev = 300
        @gravity = 2
        @jump_ok = false
        @map = map
    end

    #対応する配置パーツ番号を返す
    def collision_tile(x,y,array)
        return array[y/32][x/32]
    end

    def update

        #重力の設定
        y_move = (self.y - @y_prev) + @gravity
        #すり抜け防止
        if y_move > 31
            y_move = 31
        end
        if y_move < -31
            y_move = -31
        end
        @y_prev = self.y
        self.y += y_move
        @gravity = 2

        #天井衝突
        if(collision_tile(self.x,self.y,@map)== 1 or collision_tile(self.x+31,self.y,@map) == 1)
            self.y = self.y/32 * 32 + 32
        end

        #床衝突判定
        #キャラの右下端と左下端の座標が障害物パーツであった場合
        if collision_tile(self.x,self.y+31,@map) == 1 or collision_tile(self.x+31,self.y+31,@map) == 1 or
        collision_tile(self.x,self.y+31,@map) == 2 or
        collision_tile(self.x+31,self.y+31,@map) == 2
            self.y = self.y/32*32 #32で割って余りを切り捨て、再び掛けたとき、Yが32の倍数になるようにする
            @jump_ok = true #地面に接地しているのでジャンプを許可する
        else
            @jump_ok = false #地面に接地していないので、ジャンプは許可しない
        end

        #左右移動
        self.x += Input.x * 10

        #壁(左側)との衝突判定
        if collision_tile(self.x,self.y,@map) == 1 or collision_tile(self.x,self.y+31,@map) == 1 or
        collision_tile(self.x,self.y,@map) == 2 or collision_tile(self.x,self.y+31,@map) == 2
            self.x = self.x/32*32 + 32
        end
        #壁(右側)との衝突判定
        if collision_tile(self.x+31,self.y,@map) == 1 or collision_tile(self.x+31,self.y+31,@map) == 1 or
        collision_tile(self.x+31,self.y,@map) == 2 or collision_tile(self.x+31,self.y+31,@map) == 2
            self.x = self.x/32*32
        end

        #ジャンプ
        if Input.key_push?(K_SPACE) && @jump_ok
            @gravity = -20
        end

        #描画
        self.draw
    end
end
