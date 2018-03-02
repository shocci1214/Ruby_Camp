class Button
    def initialize(x,y,font_contents,sound)
        #ボタンを描画する位置
        @x = x
        @y = y
        @image = Image.new(200,50).box_fill(0,0,200,50,[0,0,255])
        @font = Font.new(30,'MSゴシック')
        @font_contents = font_contents
        @sound = sound
    end
    def update
        if Input.mouse_x > @x && Input.mouse_x < @x + @image.width && Input.mouse_y > @y && Input.mouse_y < @y+ @image.height
            @image.box_fill(0,0,200,50,[0,80,255])
            if Input.mouse_push?(M_LBUTTON)
                @sound.play
                Scene.move_to(:game)
            end
        else
            @image.box_fill(0,0,200,50,[0,0,255])
        end

        Window.draw(@x,@y,@image,-1)
        Window.draw_font(@x+55,@y+10,@font_contents,@font)

    end
end

class ExitButton < Button
    def update
        super
        if Input.mouse_x > @x && Input.mouse_x < @x + @image.width && Input.mouse_y > @y && Input.mouse_y < @y+ @image.height
            @image.box_fill(0,0,200,50,[0,80,255])
            if Input.mouse_push?(M_LBUTTON)
                @sound.play
            end
        else
            @image.box_fill(0,0,200,50,[0,0,255])
        end
    end
end
