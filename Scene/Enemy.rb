class Enemy < Sprite
    def initialize
        super
        self.image = Image.new(50,50).triangle_fill(0,0,50,0,25,25,[255,255,0,0])
        self.x = rand(Window.width)
        self.y = 100

    end

    def update
        self.draw
        self.y += 10

        if self.y > Window.height
            self.vanish
        end
    end

end
