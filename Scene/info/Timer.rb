class Timer
    attr_accessor :time
    def initialize(time)
        @time = time
    end

    def update
        @time -= 1.0 / 60.0
        Window.draw_font(10,10,"Timer: #{sprintf("%.1f",@time)}",Font.default)
    end
end
