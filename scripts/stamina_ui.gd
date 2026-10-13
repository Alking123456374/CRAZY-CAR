extends Control

@onready var player = $"../../player"
@onready var bar: ProgressBar = $StaminaBar
@onready var label: Label = $Label


func _ready() -> void:
	bar.max_value = player.max_stamina
	bar.value = player.max_stamina


func _process(delta: float) -> void:
	# 显示值逐渐接近实际体力，形成平滑动画。
	bar.value = move_toward(
		bar.value,
		player.stamina,
		player.max_stamina * delta
	)

	# 低体力变橙色，耗尽变红色。
	var fraction: float = player.stamina / player.max_stamina
	var target_color := Color(0.35, 0.9, 0.65)

	if fraction <= 0.0:
		target_color = Color(1.0, 0.3, 0.3)
	elif fraction <= 0.3:
		target_color = Color(1.0, 0.7, 0.25)

	# 颜色也逐渐过渡。
	bar.modulate = bar.modulate.lerp(
		target_color,
		minf(delta * 10.0, 1.0)
	)
