require 'dxruby'
require_relative 'Scene'
require_relative 'Scene/scene_title/Director'
require_relative 'Scene/scene_game/Director'

#ゲーム名
Window.caption = "シューティングてきな"

#Sound
START_SOUND = Sound.new('./Sound/start.wav')
EXIT_SOUND = Sound.new('./Sound/exit.wav')
BGM_SOUND = Sound.new("./Sound/bgm.mid")
BGM_SOUND.loop_count = -1
PLAYER_SHOT_SOUND = Sound.new("./Sound/playershot.wav")
EXPLOSION_SOUND = Sound.new("./Sound/explosion.wav")
DAMAGE_SOUND = Sound.new("./Sound/damage.wav")
END_SOUND = Sound.new("./Sound/end.wav")

#シーンの追加
Scene.add(Title::Director.new, :title)
Scene.add(Game::Director.new, :game)

#タイトル画面へ移行
Scene.move_to(:title)

#メインループ
Window.loop do
    Scene.play

    #ESCで終了
    break if Input.key_push?(K_ESCAPE)
end
