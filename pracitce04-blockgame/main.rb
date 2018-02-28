require 'dxruby'
require_relative 'Scene'
require_relative 'Scene/scene_title/Director'
require_relative 'Scene/scene_game/Director'


#ゲーム名
Window.caption = "ブロックくずし"

#画面サイズ
Window.width = 640
Window.height = 480

#シーンの追加
Scene.add(Title::Director.new, :title)
Scene.add(Game::Director.new, :game)

#Sounds
WALL_SOUND = Sound.new("./Sound/wall.wav")
BLOCK_SOUND = Sound.new("./Sound/block.wav")

#タイトル画面へ移行
Scene.move_to(:title)

Window.loop do
    # Window.draw_font(100,100,'HelloWorld',Font.default)
    Scene.play

    #ESCで終了
    break if Input.key_push?(K_ESCAPE)
end
