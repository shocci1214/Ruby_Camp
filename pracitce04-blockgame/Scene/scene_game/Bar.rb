class Bar < Sprite
    def initialize(x,y)
        self.x = x
        self.y = y
        self.image = Image.new(100,20,C_WHITE)
    end

    def update
        #左右移動
        self.x += 15 if Input.key_down?(K_RIGHT) && self.x < Window.width - 120
        self.x -= 15 if Input.key_down?(K_LEFT) && self.x > 20

        #描画
        self.draw
    end
end
