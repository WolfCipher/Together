extends Node2D

@onready var color_rect = $ColorRect

func _ready() -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE # doesn't absorb clicks; allows clicks to go through to buttons
	SceneCache.create_fog.connect(create_fog)
	
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color(1,1,1,0), 0)

func create_fog(to_fade_in, to_fade_out):
	print("making fog")
	
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color(1,1,1,1), 1.0)
	await get_tree().create_timer(1.0).timeout
	
	to_fade_in.visible = true
	to_fade_in.process_mode = PROCESS_MODE_INHERIT
	to_fade_out.visible = false
	to_fade_out.process_mode = PROCESS_MODE_DISABLED
	
	var tween2 = create_tween()
	tween2.tween_property(color_rect, "modulate", Color(0,0,0,0), 0.4)
