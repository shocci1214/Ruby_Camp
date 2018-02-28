class Block < Sprite
    def initialize(x,y,color)
        self.x = x
        self.y = y
        self.image = Image.new(58,18,color)
        @color = color
    end

    def hit
        self.vanish
    end
end
