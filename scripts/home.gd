extends Control

const DESIGN_SIZE := Vector2(1152, 648)

@onready var layout: Control = $Layout
@onready var score_label: Label = $Layout/Menu/ScorePanel/Label2
@onready var start_button: Button = $Layout/Menu/Button


func _ready() -> void:
	score_label.text = "%03d" % Global.historyScore
	score_label.add_theme_font_size_override("font_size", mini(32, int(96.0 / score_label.text.length())))
	resized.connect(_fit_layout)
	_fit_layout()
	start_button.grab_focus()
	var menu: Control = $Layout/Menu
	var preview: Control = $Layout/Preview
	menu.modulate.a = 0.0
	preview.modulate.a = 0.0
	var entrance := create_tween().set_parallel(true)
	entrance.tween_property(menu, "modulate:a", 1.0, 0.35)
	entrance.tween_property(preview, "modulate:a", 1.0, 0.5)


func _fit_layout() -> void:
	var ratio := minf(size.x / DESIGN_SIZE.x, size.y / DESIGN_SIZE.y)
	layout.scale = Vector2.ONE * ratio
	layout.position = (size - DESIGN_SIZE * ratio) * 0.5


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/game.tscn")
