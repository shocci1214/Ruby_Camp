#----------------------------------------------------------------
#
# ブロッック崩し
#
#----------------------------------------------------------------
# Spriteを継承 & 構成要素のクラス化版
#----------------------------------------------------------------
# 1)block10_class.rb(Sprite未使用+クラス化版)からSprite継承を行い。
# 2)ブロック崩しの機能を追加した。
#----------------------------------------------------------------
# 機能追加
#
# 1) block
#  (1) blockのカラー化
#      ・block_type = 0 :各行の色を変える.
#                   = 1 :各列の色を変える。
#                   = 2 :斜めの色を変える。
#                   = 3 :ランダム配色
#                   = 4 :map指定
#  (2) blockのpoint追加
#     ・色とpointは対応,getしたpointの計算と表示
#     ・得点 = 当たったblocksのpointsの総計
#       class Ballのhit= self.check(blocks).firstから
#       hit.pointで当たったblocksのpointが得られる。
#       ==>うまくcountされていない。(少なくcountされる)
#       ==> Sprite,clean(blocks)を行うと正常countになる。
#     ・残りblockのpointの総計から得点を逆算する方法も
#       行った。
#  (3) Blockの配置パターン
#     ・設定した色のblockを除いて配置することも可能。
#       block_arrange = 0-4  色配列colorsの要素番号を抜く。
#     ・map type block_arrange=4 追加
#
# 2) bar
#   (1)動作範囲
#      ・マウス位置をbarの左上->中央に変更。
#      ・縦方向にもある範囲で可動にした。
#        ==>これでもballのblock衝突方向に変化を与えられる。
#   (2)回転可能
#      key_Z : 反時計廻り、key_X :時計廻り
#   (3)拡大、縮小
#      x方向のみ。
#       key_A : 拡大、key_S :縮小  ==> 将来は経過時間などと連動
#
# 3) ball
#    (1)スピード
#      ・初期位置の乱数化(北村さん作)
#        (2)reset時の発射ball速度の乱数化は実施済み
#      ・高得点blockに当たったらスピードアップする。(未完)
#    (2)reset
#       Game startから設定時間までは、Ballが下に外れてしまっても
#       ballがbar上に戻り、左マウスクリックで再スタート出来る様にした。
#       (Game開始間もなくでGame Overになった場合、再起動するのは
#        面倒なので敗者復活にした)
#    (3)複数ball
#        時間 or get pointとの連動も。(未完)
#
# 4) その他
#    (1)経過時間の計算と表示
#    (2)効果音
#        ballがblockに当たった時に発生させる。
#        効果音はDXRuby-Sampleから借用。
#    (3) blocksとbarの間に邪魔物体(自動的に左右に動く)を置く。
#        邪魔物体に当たったら、方向転換 & 減点などのペナルティー
#        を与える。 (未完)
#----------------------------------------------------------------
require 'dxruby'

class Bar < Sprite
  def initialize(x, y)
    self.x = x
    self.y = y
    self.image = Image.new(100, 20, C_WHITE)
  end

  def slide(mouse_x, mouse_y)
    #self.x = Input.mouse_pos_x
    self.x =mouse_x - self.image.width / 2
    #y方向もある範囲で移動可に
    self.y =mouse_y
    self.y = $height - 50                if self.y < $height - 50
    self.y = $height - self.image.height if self.y > $height
  end

  #回転
  def rotate(dr)
    self.angle +=dr
  end

  #拡大,縮小
  def scalex(ds)
    self.scale_x +=ds
  end
end

class Wall< Sprite
  def initialize(x, y, image)
    self.x = x
    self.y = y
    self.image = image
  end
end

$tpoint = 0    #For point_calc
class Ball < Sprite
  attr_accessor :dx, :dy     #state=2で使用
  def initialize(x, y)
    self.x = x
    self.y = y
    self.image = Image.new(20, 20).circle_fill(10, 10, 10, C_WHITE)
    @dx = 4
    @dy = -4
  end

  def update(walls, bar, blocks)
    self.x += @dx
    if self === walls or self === bar
      self.x -= @dx
      @dx *=-1
      $s2.play    #sound
    end

    hit = self.check(blocks).first
    if hit !=nil
      hit.vanish
      $tpoint += hit.point   #For point_calc
      self.x -= @dx
      @dx *=-1
      $s1.play    #sound
    end

    self.y +=@dy
    if self === walls or self === bar
      self.y -= @dy
      @dy *= -1
      $s2.play    #sound
    end

    hit = self.check(blocks).first
    if hit !=nil
      hit.vanish
      $tpoint += hit.point   #For point_calc
      self.y -= @dy
      @dy *=-1
      $s1.play    #sound
    end
  end
end

class Block < Sprite
  attr_accessor :color, :point  #Add
  def initialize(x, y, color, point)
    self.x = x
    self.y = y
    self.image = Image.new(58, 18, color)
    @color = color
    @point = point
  end
end

$width  = Window.width
$height = Window.height
#sound
# DXRuby-Sampleから転用
# 50mSecの効果音。ブロック内は1msの変化
# v : ボリューム
# ブロックの戻り値の配列：[周波数,ボリューム]
#
v = 80
$s1 = SoundEffect.new(50) do
  v = v - 4 if v > 0
  [220, v]
end
v = 80
$s2 = SoundEffect.new(50) do
  v = v - 4 if v > 0
  [440, v]
end
v = 80
$s3 = SoundEffect.new(50) do
  v = v - 4 if v > 0
  [880, v]
end

#----Block--------------------------------------------------------
#設定
block_color   = 4       #色 & point 設定   : 0,1,2,3,4
block_arrange = 5       #block配置(穴あけ) : 0--4(抜くblockの色を設定)

#block pointの総計計算用
tpoint_start = 0
blocks = []
#--------------------------
if block_color <=3
#--------------------------
#data
colors = [C_BLUE, C_YELLOW, C_WHITE, C_RED, C_GREEN]
points = [50,40,30,20,10]

5.times do |y|
  10.times do |x|
    if block_color == 0        #行同色
       ind = y
    elsif block_color == 1     #列同色
       ind = x % 5
    elsif block_color == 2
       ind = (x + y) % 5       #斜め同色
    elsif block_color == 3
       ind = rand(5)           #Random
    end
    blocks << Block.new(21 + 60 * x , 21 + 20 * y, colors[ind], points[ind])
    tpoint_start +=points[ind]
  end
end

if block_arrange >=0 and block_arrange <5
  blocks.delete_if do |block|
    if block.color== colors[block_arrange]
       tpoint_start -=block.point
     end
  end
end
#---------------------------
else
# kitamura-san version
if block_color == 4
#---------------------------
colors2 = [C_BLUE, C_YELLOW, C_WHITE, C_RED, C_GREEN, C_WHITE, C_GREEN]
points2 = [50,40,30,20,10,30,10]
layout = [
              [1,0,0,0,0,0,0,0,0,1],
              [0,0,0,0,1,1,0,0,0,0],
              [0,0,1,1,1,1,1,1,0,0],
              [0,1,1,1,1,1,1,1,1,0],
              [1,1,1,1,1,1,1,1,1,1],
              [0,1,1,1,1,1,1,1,1,0],
              [0,0,1,1,1,1,1,1,0,0]
             ]
    7.times do |y|
      10.times do |x|
        blocks << Block.new(21 + 60 * x , 21 + 20 * y, colors2[y], points2[y]) if layout[y][x] == 1
        tpoint_start +=points2[y] if layout[y][x] == 1
      end
    end
end
end
#----bar, ball, walls--------------------------------------------#
bar = Bar.new(0, 460)
ball = Ball.new(rand * 500 + 50, 400)  # modify following kitamura-sann
walls =[]
walls << Wall.new(0,   0, Image.new(20, 480, C_WHITE))
walls << Wall.new(0,   0, Image.new(640, 20, C_WHITE))
walls << Wall.new(620, 0, Image.new(20, 480, C_WHITE))

#-----Other setting----------------------------------------------#
#Font
font = Font.new(20) #, "MS明朝", {:weight=>false, :italic=>true} )
font2 = Font.new(50)

#Initial Condition
#Time
start_time = Time.now
#State
state = 0
REVTIME = 60   #単位[sec]

Window.loop do
  bar.slide(Input.mouse_pos_x, Input.mouse_pos_y)
  bar.draw
  ball.update(walls, bar, blocks)
  ball.draw
  Sprite.draw(walls)
  Sprite.draw(blocks)

  ## Additional Option ##
  # Bar rotation:引数は回転角増加量[単位は度)
    bar.rotate(1.0)    if Input.key_down?(K_Z)  #反時計廻り
    bar.rotate(-1.0)   if Input.key_down?(K_X)  #時計廻り

  # Bar scaling:引数は拡大比率増加量
    bar.scalex(0.1)     if Input.key_push?(K_A)  #拡大
    bar.scalex(-0.1)    if Input.key_push?(K_S)  #縮小

  #point calc
  Sprite.clean(blocks) #この処理ないとclass Ball内での
                       # hit.pointが正しく計算されない。

  ## getしたpointの計算別法 ##
  # 残っているblocksのpoint合計を計算し、Game開始前の
  # point総和から差し引く
  #
  #ttpoint = 0
  #blocks.each do |block|
  #  ttpoint +=block.point
  #end
  #point_now = tpoint_start - ttpoint

  #time calc
  now_time = Time.now
  $elapsed_time = now_time - start_time

  #state calc
  state = 1  if ball.y > $height                                #Game Over
  state = 2  if ball.y > $height and $elapsed_time < REVTIME    #Revenge
  state = 3  if $tpoint == tpoint_start   #blocks.length == 0   #Clear

  #control
  if state == 2
    ball.x = bar.x + bar.image.width / 2
    ball.y = bar.y - ball.image.height
    if Input.mouse_push?(M_LBUTTON)
      state = 0
      ball.dx = rand(2) * 16 - 8
      ball.dy = -8
    end
  end
  if state == 1 or state == 3
    break
  end

  #display
  Window.draw_font( 50, $height - 230, "Time:#{$elapsed_time.round(0)}  sec", font, {:color=>C_YELLOW})
  Window.draw_font( 50, $height - 200, "Total Point:#{tpoint_start} \nGeted Point:#{$tpoint}", font, {:color=>C_YELLOW})
  break if Input.key_push?(K_ESCAPE)
end

#game over & clear screen
if state==1
  #Window.bgcolor = C_WHITE  これ(window画面を白くする)だと画面にblocks画像が残ってしまう。
  screen = Image.new($width, $height, C_BLACK)
  Window.draw(0,0,screen)
  Window.draw_font($width / 2 - 150, $height / 2, "Game Over !!", font2, {:color=>C_RED})
  Window.update
  sleep 2
end
if state == 3
  screen = Image.new($width, $height, C_WHITE)
  Window.draw(0,0,screen)
  Window.draw_font($width / 2 - 100, $height / 2, "Clear !!", font2, {:color=>C_RED})
  Window.update
  sleep 2
end
