class Button
    @@stage_count = 1
    def initialize(x,y,font_contents,sound,to:)
        #ボタンを描画する位置
        @x = x
        @y = y
        @image = Image.new(200,50).box_fill(0,0,200,50,[0,0,255])
        @font = Font.new(30,'MSゴシック')
        @font_contents = font_contents
        @sound = sound
        @to = to #文字列
    end

    def self.stage_count
        @@stage_count += 1
    end

    def update
        if Input.mouse_x > @x && Input.mouse_x < @x + @image.width && Input.mouse_y > @y && Input.mouse_y < @y+ @image.height
            @image.box_fill(0,0,200,50,[0,80,255])
            if Input.mouse_push?(M_LBUTTON)
                @sound.play
                sleep(0.5)
                if @to.match(/game.?/)
                    BGM_SOUND.play
                end
                Scene.move_to((@to+@@stage_count.to_s).to_sym)
            end
        else
            @image.box_fill(0,0,200,50,[0,0,255])
        end

        Window.draw(@x,@y,@image,-1)
        Window.draw_font(@x+55,@y+10,@font_contents,@font)
    end
end


class BackButton < Button
    def update
        if Input.mouse_x > @x && Input.mouse_x < @x + @image.width && Input.mouse_y > @y && Input.mouse_y < @y+ @image.height
            @image.box_fill(0,0,200,50,[0,80,255])
            if Input.mouse_push?(M_LBUTTON)
                @sound.play
                sleep(0.5)
                Scene.move_to(@to)
            end
        else
            @image.box_fill(0,0,200,50,[0,0,255])
        end

        Window.draw(@x,@y,@image,-1)
        Window.draw_font(@x+55,@y+10,@font_contents,@font)
    end
end
