class Enemy < Sprite
    @@enemies = []
    def initialize
        super
        self.image = Image.new(80,80).triangle_fill(0,0,80,0,40,40,[255,255,0,0])
        self.x = rand(Window.width)
        self.y = 0

    end

    def self.get_enemies
        return @@enemies
    end

    def update
        self.draw
        self.y += 5

        if self.y > Window.height
            self.vanish
        end
    end

    def hit(obj)
        self.vanish
    end

end
