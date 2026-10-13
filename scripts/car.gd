extends Area2D


@export var SPEED = -200.0


func _ready() -> void:
	if position.x < 0:
		SPEED *= -1
		$carSprite.flip_h = true
		
func _physics_process(delta: float) -> void:
	
	var direction = Vector2.RIGHT
	position += direction * (SPEED + Global.score * 10) * delta 


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
