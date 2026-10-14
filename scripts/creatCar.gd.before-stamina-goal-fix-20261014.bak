extends Node2D

#@onready var timer : Timer = $Timer
@export var carList : Array[PackedScene]
@onready var voice : AudioStreamPlayer = $"../Audio/crash"
var noRepeat :Vector2 = Vector2.ZERO
@export var bodyImg : PackedScene

func _on_timer_timeout() -> void:
	buildCar()
	
# 创建一辆车子
func buildCar():
	var car: PackedScene = carList.pick_random()
	var instance = car.instantiate() as Area2D
	var creatPoint = $".".get_children().pick_random()
	if noRepeat != creatPoint.position:
		instance.position = creatPoint.position
		$"../carInstance".add_child(instance)
		noRepeat = creatPoint.position
		
		instance.connect("body_entered",take_damage)
	else:
		return

# 被车撞触发条件
func take_damage(body):
	voice.playing = true
	Global.inputEnable = false
	$"../player/CollisionShape2D".set_deferred("disabled",true)
	Global.currentHp -= 1
	get_parent().update_HP(Global.currentHp)
	creat_body($"../player".position)
	await get_tree().create_timer(1.0).timeout
	
	if Global.currentHp > 0:
		respawn_body(Global.playerPosition)
	else:
		get_tree().change_scene_to_file("res://scene/home.tscn")
		
# 生成一个尸体
func creat_body(bodyPositon : Vector2):
	var body = bodyImg.instantiate()
	body.position = bodyPositon
	$"../player".visible = false
	$"../basic_Map".add_child(body)
	
# 玩家复活
func respawn_body(bodyPositon : Vector2):
	$"../player".visible = true
	$"../player/CollisionShape2D".set_deferred("disabled",false)
	$"../player".position = bodyPositon
	Global.inputEnable = true
	
