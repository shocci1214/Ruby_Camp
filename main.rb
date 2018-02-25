require 'dxruby'
require 'smalrubot'
require_relative 'Scene'
require_relative 'Scene/scene_title/director'
require_relative 'Scene/scene_game/director'
require_relative 'Scene/scene_gameover/director'

#-----------------------
#ゲーム画面　横800 縦600
#------------------------
Window.width = 800
Window.height = 600

#self.add(scene_obj,scene_name)
Scene.add(Title::Director.new, :title)
Scene.add(Game::Director.new, :game)
Scene.add(Gameover::Director.new, :gameover)

Scene.move_to(:title)

#-----------------------
#初期化
#------------------------

$PlayerShot = []
#敵プレイヤー配列
$Enemies = []


#-----------------
#メインループ
#-----------------

Window.loop do

    Scene.play

    #ESCで終了
    break if Input.key_push?(K_ESCAPE)

    #arudino
    # #30フレーム（＝0.5秒）ごとにセンサーの入力を受け付ける
    #デジタル(0,1か)
    # p board.digital_read(2) if frm == 30
    #アナログの場合(一定のノイズが入る、測定誤差←これをどう是正するか？)
    #（デジタルフィルター）
    #↓これだとかくかく インスタンス変数にかませたほうがよい
    #player.x += board.analog_read(2) if frm == 30
    # frm += 1
    # frm = 0 if frm > 30

end
