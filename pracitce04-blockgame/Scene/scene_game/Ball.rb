class Ball < Sprite
    attr_accessor :dx, :dy
    def initialize(x,y)
        self.x = x
        self.y = y
        self.image = Image.new(20,20).circle_fill(10,10,10,C_WHITE)
        @dx = 8
        @dy = -8
    end

    def shot
        self.x += @dx
        @dx *= -1
        self.y += @dy
        @dy *= -1
    end

    def update(walls,bar,blocks)
        self.x += @dx

        if self === walls || self === bar
            self.x -= @dx
            @dx *= -1
        end

        self.y += @dy
        if self === walls || self === bar
            self.y -= @dy
            @dy *= -1
        end
    end
end
