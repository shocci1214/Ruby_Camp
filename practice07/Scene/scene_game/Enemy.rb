class Enemy < Sprite
    def initialize
        super
        self.x = 50
        self.y = 30
        self.image = Image.new(50,50).box_fill(0,0,50,50,[255,255,0,0])
    end
    def update
    end
end
