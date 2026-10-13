extends CharacterBody2D

var direction:Vector2 = Vector2(1,1)
@export var speed:float = 50
@export var run_speed:float = 100
@export var max_stamina: float = 100.0
@export var stamina_cost: float = 50.0
@export var stamina_recovery: float = 10.0

@onready var stamina: float = max_stamina
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.inputEnable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	if Global.inputEnable == false:
		$AnimatedSprite2D.frame = 0
		return
		
	var run_pressed := Input.is_action_pressed("run")
	
	# 按住消耗，松开恢复。
	if run_pressed:
		stamina = maxf(stamina - stamina_cost * delta, 0.0)
	else:
		stamina = minf(stamina + stamina_recovery * delta,max_stamina)
			
	# 有体力时才允许跑步。
	var running := run_pressed and stamina > 0.0
	var move_speed : float = run_speed if running else speed

	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * move_speed

	# 跑步时，现有行走动画播放得更快。
	$AnimatedSprite2D.speed_scale = 1.6 if running else 1.0
	
	animation_walk()
	move_and_slide()
	
func animation_walk():
	if direction:
		if direction.x > 0:
			$AnimatedSprite2D.play('right_walk')
		if direction.x < 0:
			$AnimatedSprite2D.play('left_walk')
		else:
			if direction.y < 0:
				$AnimatedSprite2D.play('forward_walk')
			if direction.y > 0:
				$AnimatedSprite2D.play('back_walk')
	else:
		$AnimatedSprite2D.frame = 0

func is_player_run():
	if Input.is_action_pressed("run"):
		return true
	else:
		return false
