require 'dxruby'

Window.width = 1200


#ゲームコントロール
state = 1
#ゲージ増減スピードコントール
count = 0
#ゲージの初期位置
gage_y = 400
#ゲージの外側
gage_outline = Image.new(50,300).box(0,0,50,300,C_WHITE)
#フォント
font = Font.new(30,"MSゴシック")

#得点ボード
class Board
    def initialize
        @x = 900
        @y = 150
        @image = Image.new(200,200).box(0,0,200,200,C_BLUE)
    end
    def draw
        Window.draw(@x,@y,@image)
    end
end

#ボール
class Ball
    attr_accessor :x,:image
    def initialize
        @x = 300
        @y = 200
        @image = Image.new(100,100).circle_fill(50,50,50,C_RED)
        @dx = 0
    end
    def draw
        Window.draw(@x,@y,@image)
    end
end


#ボール
ball = Ball.new
#得点用ボード
board = Board.new

Window.loop do

    #ボール
    ball.draw

    #得点用ボード
    board.draw

    #ゲージ 枠
    Window.draw(100,100,gage_outline)

    #クリックでゲージを止める
    if Input.mouse_push?(M_LBUTTON) && state != 4
        state = 0
    end

    #コントロール
    #down: 1  up: 2
    state = 2 if gage_y+10 > 400 && state == 1
    state = 1 if gage_y -10 < 100 && state == 2

    if count % 2 == 0
        if state == 1
            gage_y += 10
        elsif state == 2
            gage_y -= 10
        end
    end
    count += 10

    #ゲージ
    Window.draw_box_fill(100,gage_y,149,400,C_WHITE,1)

    #Info
    #Powerの表示
    if state == 0
        Window.draw_font(50,70,"Power:#{400 - gage_y}",font)
        ball.x += 10 if (ball.x - 300) <= (400 - gage_y) * 3
        if (ball.x - 300) == (400 - gage_y) * 3
            state = 4
        end
    end
    Window.draw_font(50,420,'クリックでとめてね！',font)

    if state == 4
        Window.draw_font(50,70,"Power:#{400 - gage_y}",font)
        Window.draw_font(400,420,'投げました！',font)
    end


end
