extends Node2D

@export var fade_in = true
@export var fade_out = true
@onready var color_rect = $ColorRect

func _ready() -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE # doesn't absorb clicks; allows clicks to go through to buttons
	SceneCache.scene_change.connect(on_scene_change)
	
	color_rect.color = Color(0,0,0,0)
	visible = true
	
	if fade_in:
		color_rect.color = Color(0,0,0,1)
		var tween = create_tween()
		tween.tween_property(color_rect, "modulate", Color(0,0,0,0), 0.4)

func on_scene_change(next_scene):
	
	if fade_out:
		var tween = create_tween()
		tween.tween_property(color_rect, "modulate", Color(0,0,0,1), 0.4)
		await get_tree().create_timer(0.4).timeout
		
	get_tree().change_scene_to_file(next_scene)
