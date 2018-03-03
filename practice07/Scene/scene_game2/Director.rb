require_relative '../Lib/Player'
require_relative '../Lib/Enemy'
require_relative '../Lib/Info'
require_relative '../scene_gameover/Director'

module Game2
    class Director < Game1::Director
        def initialize
            super
            @info = Info.new(timer:5,score:0,playerlife:3,stage:2)
        end
        def play
            super
            Enemy.generator(@count,@enemies,500)
        end
    end
end
