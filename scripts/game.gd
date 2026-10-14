extends Node2D

@export var scoreLabel : Label 
@export var hpCanvas : HBoxContainer
@export var heartImg: Texture2D
@export var peopleImg : PackedScene
@export var timer : Timer

func _ready() -> void:
	Global.currentHp = Global.maxHp
	update_HP(Global.currentHp)
	$basic_Map/Area2D.connect("body_entered",on_goal_body_entered)


func on_goal_body_entered(body: Node2D) -> void:
	# 只有当前玩家可以得分。
	if body != $player:
		return
	# 得分后更新分数，玩家回到出发点，增加游戏难度
	update_score()
	reset_game()
	up_car_creat()
	
# 更新玩家分数
func update_score():
	# 得分音效
	$Audio/getScore.playing = true
	
	#加分系统
	Global.score += 1
	scoreLabel.text = "score: " + str(Global.score)
	if Global.score > Global.historyScore:
		Global.historyScore = Global.score

# 更新玩家生命值
func update_HP(hp : int):
	while hpCanvas.get_child_count() >  Global.currentHp:
		var heart = hpCanvas.get_child(hpCanvas.get_child_count() - 1)
		hpCanvas.remove_child(heart)
		heart.queue_free()
		
	
	while hpCanvas.get_child_count() <  Global.currentHp:
		var heart = TextureRect.new()
		heart.texture = heartImg
		heart.custom_minimum_size = Vector2(35,35)
		heart.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		hpCanvas.add_child(heart)
		
# 得分后留下玩家模型并重置玩家位置
func reset_game():
	await get_tree().create_timer(2.0).timeout
	var setPosition = $player.position
	var people = peopleImg.instantiate()
	people.position = setPosition
	people.z_as_relative = false
	people.z_index = 100
	$player.position = Global.playerPosition
	$player.stamina = $player.max_stamina
	$basic_Map.add_child(people)
	
# 得分后加快车生成速度
func up_car_creat():
	
	if timer.wait_time > 0.05:
		timer.wait_time -= Global.score * 0.01
		print("得分：", Global.score, " 生成间隔：", timer.wait_time)
