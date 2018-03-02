require 'dxruby'

Window.width = 700
Window.height = 700

#ボタンクラス
class Button
    def initialize(x,y,font_contents,sound)
        @x = x
        @y = y
        @image = Image.new(200,200).box_fill(0,0,200,200,[0,0,255])
        @font = Font.new(30,'MSゴシック')
        @font_contents = font_contents
        @sound = sound
    end

    def update
        #マウスオーバーでボタンの色を透明にする
        if Input.mouse_x > @x && Input.mouse_x < @x+200 && Input.mouse_y > @y && Input.mouse_y < @y+200
            @image.box_fill(0,0,200,200,[0,80,255])
            if Input.mouse_push?(M_LBUTTON)
                @sound.play
            end
        else
            @image.box_fill(0,0,200,200,[0,0,255])
        end



        Window.draw(@x,@y,@image,-1)
        Window.draw_font(@x+20,@y+80,@font_contents,@font)
    end
end

#Sound
BUTTON1_VOICE = Sound.new('./Sound/button1_voice.wav')
BUTTON2_VOICE = Sound.new('./Sound/button2_voice.wav')
BUTTON3_VOICE = Sound.new('./Sound/button3_voice.wav')
BUTTON4_VOICE = Sound.new('./Sound/button4_voice.wav')

#button
button1 = Button.new(100,100,'なんでやねん',BUTTON1_VOICE)
button2 = Button.new(400,100,'もうええわ',BUTTON2_VOICE)
button3 = Button.new(100,400,'おおきに',BUTTON3_VOICE)
button4 = Button.new(400,400,'あかん',BUTTON4_VOICE)


Window.loop do

    button1.update
    button2.update
    button3.update
    button4.update
    #ESCキーで終了
    break if Input.key_push?(K_ESCAPE)
end
