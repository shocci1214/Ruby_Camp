require 'dxruby'
require_relative 'Scene'
require_relative 'Scene/scene_title/Director'
require_relative 'Scene/scene_game/Director'

#ゲーム名
Window.caption = "あくしょんゲーム的ななにか"

#画面サイズ 横800 縦600
Window.width = 1200
Window.height = 600

#シーンの追加
Scene.add(Title::Director.new, :title)
Scene.add(Game::Director.new, :game)

#Sounds
JUMP_SOUND = Sound.new('./Sound/jump.wav')

#タイトル画面へ移行
Scene.move_to(:title)

Window.fps = 30

#メインループ
Window.loop do
    Scene.play

    #ESCで終了
    break if Input.key_push?(K_ESCAPE)
end
