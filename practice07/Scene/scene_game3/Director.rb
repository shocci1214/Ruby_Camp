require_relative '../Lib/Player'
require_relative '../Lib/Enemy'
require_relative '../Lib/Info'
require_relative '../scene_gameover/Director'

module Game3
    class Director < Game2::Director
        def initialize
            super()
            @info = Info.new(timer:30,score:0,playerlife:3,stage:3)
        end
        def play
            super
            Enemy.generator(count:@count,enemies:@enemies,num: 300,count_rand: 100)
            
        end
    end
end
