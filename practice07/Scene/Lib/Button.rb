class Button
    @@stage_count = 1
    def initialize(x,y,font_contents,sound,to:)
        #ボタンを描画する位置
        @x = x
        @y = y
        @image = Image.new(280,50).box_fill(0,0,280,50,[0,0,255])
        @font = Font.new(30,'MSゴシック')
        @font_contents = font_contents
        @sound = sound
        @to = to #文字列
    end

    def self.stage_count
        @@stage_count += 1
    end

    def self.stage_reset
        @@stage_count = 1
    end

    def update
        if Input.mouse_x > @x && Input.mouse_x < @x + @image.width && Input.mouse_y > @y && Input.mouse_y < @y+ @image.height
            @image.box_fill(0,0,280,50,[0,80,255])
            if Input.mouse_push?(M_LBUTTON)
                @sound.play
                sleep(0.5)
                if @to.match(/game.?/)
                    BGM_SOUND.play
                end
                Enemy.reset_enemyshots
                Scene.move_to((@to+@@stage_count.to_s).to_sym)
            end
        else
            @image.box_fill(0,0,280,50,[0,0,255])
        end

        Window.draw(@x,@y,@image,-1)
        Window.draw_font(@x+55,@y+10,@font_contents,@font)
    end
end


class BackButton < Button
    def update
        if Input.mouse_x > @x && Input.mouse_x < @x + @image.width && Input.mouse_y > @y && Input.mouse_y < @y+ @image.height
            @image.box_fill(0,0,280,50,[0,80,255])
            if Input.mouse_push?(M_LBUTTON)
                @sound.play
                sleep(0.5)

                if @to == "title"
                    Button.stage_reset
                    Scene.add(Game1::Director.new, :game1)
                    Scene.add(Game2::Director.new, :game2)
                    Scene.add(Game3::Director.new, :game3)
                    Scene.add(GameOver::Director.new, :gameover)
                end
                Scene.move_to(@to)
            end
        else
            @image.box_fill(0,0,280,50,[0,0,255])
        end

        Window.draw(@x,@y,@image,-1)
        Window.draw_font(@x+55,@y+10,@font_contents,@font)
    end
end
