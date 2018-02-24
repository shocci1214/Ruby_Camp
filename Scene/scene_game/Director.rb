require_relative '../Player'
require_relative '../Enemy'
require 'smalrubot'

module Game
    class Director
        @@count = 0
        def initialize
            @player = Player.new
        end

        def play
            @player.update
            Sprite.update([$PlayerShot,$Enemies])
            @@count += 1
            if @@count % 100 == 0
                $Enemies << Enemy.new
            end
        end
    end
end
