require_relative 'Player'

module Game
    class Director
        def initialize
            @player = Player.new
            @playershots = []
        end
        def play

            @player.update(@playershots)
            Sprite.update([@playershots])
        end
    end
end
